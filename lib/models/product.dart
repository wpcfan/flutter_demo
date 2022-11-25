import 'package:demo/models/all.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    this.id,
    this.name,
    this.description,
    this.originalPrice,
    this.price,
    this.image,
    this.categories,
    this.discounts,
  });

  final int? id;
  final String? name;
  final String? description;
  final double? originalPrice;
  final double? price;
  final String? image;
  final List<Category>? categories;
  final List<Discount>? discounts;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        originalPrice,
        price,
        image,
        categories,
        discounts,
      ];

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? originalPrice,
    double? price,
    String? image,
    List<Category>? categories,
    List<Discount>? discounts,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      originalPrice: originalPrice ?? this.originalPrice,
      price: price ?? this.price,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      discounts: discounts ?? this.discounts,
    );
  }

  @override
  String toString() =>
      'Product { id: $id, name: $name, description: $description, originalPrice: $originalPrice, price: $price, image: $image, categories: $categories, discounts: $discounts }';

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        originalPrice: (json['original_price'] as num?)?.toDouble(),
        price: (json['price'] as num?)?.toDouble(),
        image: json['image'] as String?,
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        discounts: (json['discounts'] as List<dynamic>?)
            ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'original_price': originalPrice,
        'price': price,
        'image': image,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'discounts': discounts?.map((e) => e.toJson()).toList(),
      };
}
