import 'money.dart';

class AddCartItemOutput {
  final String cartId;
  final bool isEmpty;
  final bool abandoned;
  final int totalItems;
  final int totalUniqueItems;
  final Money subTotal;

  AddCartItemOutput({
    required this.cartId,
    required this.isEmpty,
    required this.abandoned,
    required this.totalItems,
    required this.totalUniqueItems,
    required this.subTotal,
  });

  factory AddCartItemOutput.fromJson(Map<String, dynamic> json) {
    return AddCartItemOutput(
      cartId: json['cartId'] as String,
      isEmpty: json['isEmpty'] as bool,
      abandoned: json['abandoned'] as bool,
      totalItems: json['totalItems'] as int,
      totalUniqueItems: json['totalUniqueItems'] as int,
      subTotal: Money.fromJson(json['subTotal'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'AddCartItemOutput(cartId: $cartId, isEmpty: $isEmpty, abandoned: $abandoned, totalItems: $totalItems, totalUniqueItems: $totalUniqueItems, subTotal: $subTotal)';
  }
}
