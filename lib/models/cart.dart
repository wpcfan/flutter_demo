import 'package:demo/models/all.dart';

class Cart {
  final String totalPrice;
  final String totalDiscount;
  final List<CartItem> cartItems;

  Cart({
    required this.totalPrice,
    required this.totalDiscount,
    required this.cartItems,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      totalPrice: json['totalPrice'],
      totalDiscount: json['totalDiscount'],
      cartItems: (json['cartItems'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList()
          .cast<CartItem>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPrice': totalPrice,
      'totalDiscount': totalDiscount,
      'cartItems': cartItems.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Cart{totalPrice: $totalPrice, totalDiscount: $totalDiscount, cartItems: $cartItems}';
  }
}
