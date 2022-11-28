part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    this.cart,
    this.loadStatus = BlocStatus.initial,
    this.addStatus = BlocStatus.initial,
    this.deleteStatus = BlocStatus.initial,
    this.updateStatus = BlocStatus.initial,
    this.error,
    this.isFetching = false,
  });
  final Cart? cart;
  final BlocStatus loadStatus;
  final BlocStatus addStatus;
  final BlocStatus deleteStatus;
  final BlocStatus updateStatus;
  final bool isFetching;
  final String? error;

  @override
  List<Object?> get props => [cart, loadStatus, error, isFetching];

  CartState copyWith({
    Cart? cart,
    BlocStatus? loadStatus,
    BlocStatus? addStatus,
    BlocStatus? deleteStatus,
    BlocStatus? updateStatus,
    bool? isFetching,
    String? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      loadStatus: loadStatus ?? this.loadStatus,
      addStatus: addStatus ?? this.addStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      isFetching: isFetching ?? this.isFetching,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'CartState{cart: $cart, loadStatus: $loadStatus, addStatus: $addStatus, deleteStatus: $deleteStatus, updateStatus: $updateStatus, isFetching: $isFetching, error: $error}';
  }
}

class CartInitial extends CartState {
  const CartInitial() : super();
}
