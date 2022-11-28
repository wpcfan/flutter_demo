import 'dart:convert';

import 'package:demo/config.dart';
import 'package:demo/models/all.dart';
import 'package:equatable/equatable.dart';

class OrderQuantity {
  final int min;
  final int max;
  final int step;
  OrderQuantity({
    this.min = minOrderQuantity,
    this.max = maxOrderQuantity,
    this.step = orderQuantityStep,
  });

  OrderQuantity copyWith({
    int? min,
    int? max,
    int? step,
  }) {
    return OrderQuantity(
      min: min ?? this.min,
      max: max ?? this.max,
      step: step ?? this.step,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'step': step,
    };
  }

  factory OrderQuantity.fromJson(Map<String, dynamic> map) {
    return OrderQuantity(
      min: map['min'],
      max: map['max'],
      step: map['step'],
    );
  }

  @override
  String toString() => 'ProductQuantity(min: $min, max: $max, step: $step)';
}

class Product extends Equatable {
  const Product({
    this.id,
    this.name,
    this.description,
    this.originalPrice,
    this.price,
    this.images = const [],
    this.categories,
    this.discounts,
    this.attributes = const [],
    this.metadata,
  });

  final String? id;
  final String? name;
  final String? description;
  final int? originalPrice;
  final int? price;
  final List<String> images;
  final List<Category>? categories;
  final List<Discount>? discounts;
  final List<NameValueAttribute> attributes;
  final Map<String, dynamic>? metadata;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        originalPrice,
        price,
        images,
        categories,
        discounts,
        metadata,
      ];

  Product copyWith({
    String? id,
    String? name,
    String? description,
    int? originalPrice,
    int? price,
    List<String>? images,
    List<Category>? categories,
    List<Discount>? discounts,
    Map<String, dynamic>? metadata,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      originalPrice: originalPrice ?? this.originalPrice,
      price: price ?? this.price,
      images: images ?? this.images,
      categories: categories ?? this.categories,
      discounts: discounts ?? this.discounts,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() =>
      'Product { id: $id, name: $name, description: $description, originalPrice: $originalPrice, price: $price, images: $images, categories: $categories, discounts: $discounts, metadata: $metadata }';

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        originalPrice: (json['original_price'] as num?)?.toInt(),
        price: (json['price'] as num?)?.toInt(),
        images: (json['images'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        discounts: (json['discounts'] as List<dynamic>?)
            ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
            .toList(),
        metadata: json['metadata'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'original_price': originalPrice,
        'price': price,
        'images': images,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'discounts': discounts?.map((e) => e.toJson()).toList(),
        'metadata': metadata,
      };

  String toAddItemCartQL({required String cartId, int quantity = 1}) => '''
    mutation {
      addItem(
        input: {
          cartId: "$cartId",
          id: "$id",
          name: "$name",
          description: "$description",
          images: ${jsonEncode(images)},
          price: $price,
          quantity: $quantity,
          attributes: [
            ${attributes.map((e) => e.toCartQL()).join(',')}
          ]
          metadata: {
            original_price: $originalPrice,
            discounts: [
              ${(discounts ?? []).map((e) => e.toCartQL()).join(',')}
            ],
            categories: [
              ${(categories ?? []).map((e) => e.toCartQL()).join(',')}
            ],
          }
        }
      ) {
        id
        isEmpty
        abandoned
        totalItems
        totalUniqueItems
        subTotal {
          formatted
        }
      }
    }
  ''';
}
