import 'package:demo/models/all.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String productId;
  final String name;
  final String description;
  final String image;
  final String price;
  final String? originalPrice;
  final int quantity;
  final List<Discount>? promoions;
  final bool isSelected;

  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.originalPrice,
    required this.quantity,
    this.promoions,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        name,
        description,
        image,
        price,
        originalPrice,
        quantity,
        promoions,
        isSelected,
      ];

  @override
  String toString() {
    return '''CartItem {
        id: $id,
        productId: $productId,
        name: $name,
        description: $description,
        image: $image,
        price: $price,
        originalPrice: $originalPrice,
        quantity: $quantity,
        promoions: $promoions,
        isSelected: $isSelected,
      }''';
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? description,
    String? image,
    String? price,
    String? originalPrice,
    int? quantity,
    List<Discount>? promoions,
    List<CartItem>? freeItems,
    bool? isSelected,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      quantity: quantity ?? this.quantity,
      promoions: promoions ?? this.promoions,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'originalPrice': originalPrice,
      'quantity': quantity,
      'promoions': promoions,
      'isSelected': isSelected,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      price: map['price'],
      originalPrice: map['originalPrice'],
      quantity: map['quantity'],
      promoions: map['promoions'] != null
          ? List<Discount>.from(
              map['promoions'].map((x) => Discount.fromJson(x)))
          : null,
      isSelected: map['isSelected'],
    );
  }
}
