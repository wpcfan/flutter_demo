enum CartItemType {
  sku('sku'),
  tax('tax'),
  shipping('shipping'),
  ;

  final String value;

  const CartItemType(this.value);
}
