import 'package:demo/helpers/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;
  CartBloc({required this.repository}) : super(const CartInitial()) {
    on<CartLoad>(_onCartLoad, transformer: throttleDroppable(throttleDuration));
    on<CartAddItem>(_onCartAddItem,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onCartLoad(CartLoad event, Emitter<CartState> emit) async {
    emit(state.copyWith(isFetching: true));
    try {
      final result = await repository.getCart(event.cartId);
      if (result.hasException) {
        emit(state.copyWith(
          status: BlocStatus.failure,
          error: result.exception.toString(),
          isFetching: false,
        ));
      } else {
        final cart = Cart.fromJson(result.data!['cart']);
        emit(state.copyWith(
          cart: cart,
          status: BlocStatus.success,
          isFetching: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }

  Future<void> _onCartAddItem(
      CartAddItem event, Emitter<CartState> emit) async {
    emit(state.copyWith(isFetching: true));
    try {
      final result = await repository.addItemToCart(
        cartId: event.cartId,
        product: event.product,
        quantity: event.quantity,
      );
      if (result.hasException) {
        emit(state.copyWith(
          status: BlocStatus.failure,
          error: result.exception.toString(),
          isFetching: false,
        ));
      } else {
        final output = AddCartItemOutput.fromJson(result.data!['addItem']);
        emit(state.copyWith(
          cart: state.cart!.copyWith(
            totalItems: output.totalItems,
            totalUniqueItems: output.totalUniqueItems,
            subTotal: state.cart!.subTotal
                .copyWith(formatted: output.subTotal.formatted),
            isEmpty: output.isEmpty,
            abandoned: output.abandoned,
          ),
          status: BlocStatus.success,
          isFetching: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }
}
