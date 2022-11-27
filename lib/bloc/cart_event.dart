part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddItem extends CartEvent {
  const CartAddItem(this.productId);

  final String productId;

  @override
  List<Object> get props => [productId];
}

class CartRemoveItem extends CartEvent {
  const CartRemoveItem(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class CartUpdateItem extends CartEvent {
  const CartUpdateItem(this.id, this.quantity);

  final String id;
  final int quantity;

  @override
  List<Object> get props => [id, quantity];
}

class CartSelectItem extends CartEvent {
  const CartSelectItem(this.id, this.isSelected);

  final String id;
  final bool isSelected;

  @override
  List<Object> get props => [id, isSelected];
}

class CartToggleSelectAll extends CartEvent {}

class CartClear extends CartEvent {}

class CartLoad extends CartEvent {
  final String id;

  const CartLoad(this.id);

  @override
  List<Object> get props => [id];
}

class CartLoaded extends CartEvent {
  const CartLoaded(this.cart);

  final Cart cart;

  @override
  List<Object> get props => [cart];
}
