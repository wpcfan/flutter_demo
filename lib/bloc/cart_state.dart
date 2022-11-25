part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    this.cart,
    this.status = BlocStatus.initial,
    this.error,
    this.isFetching = false,
  });
  final Cart? cart;
  final BlocStatus status;
  final bool isFetching;
  final String? error;

  @override
  List<Object?> get props => [cart, status, error, isFetching];

  CartState copyWith({
    Cart? cart,
    BlocStatus? status,
    bool? isFetching,
    String? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      isFetching: isFetching ?? this.isFetching,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'CartState { cart: $cart, status: $status }';
}

class CartInitial extends CartState {
  const CartInitial() : super();
}
