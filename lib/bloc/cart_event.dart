part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddItemEvent extends CartEvent {
  const CartAddItemEvent({
    required this.product,
    this.quantity = minOrderQuantity,
  });
  final Product product;
  final int quantity;

  @override
  List<Object> get props => [product, quantity];
}

class CartRemoveItemEvent extends CartEvent {
  const CartRemoveItemEvent(this.id);

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

class CartSelectItemEvent extends CartEvent {
  const CartSelectItemEvent(this.id, this.isSelected);

  final String id;
  final bool isSelected;

  @override
  List<Object> get props => [id, isSelected];
}

class CartToggleSelectAllEvent extends CartEvent {}

class CartClearEvent extends CartEvent {}

class CartLoadEvent extends CartEvent {}

class CartLoadedEvent extends CartEvent {
  const CartLoadedEvent(this.cart);

  final Cart cart;

  @override
  List<Object> get props => [cart];
}
