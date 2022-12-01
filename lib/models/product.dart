import 'dart:convert';

import 'package:demo/models/all.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.images = const [],
    this.categories,
    this.discounts,
    this.attributes = const [],
    this.metadata,
    this.specs = const [],
    this.tags = const [],
  });

  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final List<String> images;
  final List<Category>? categories;
  final List<Discount>? discounts;
  final List<KeyValueAttribute> attributes;
  final Map<String, dynamic>? metadata;
  final List<SpecAttribute> specs;
  final List<ProductTag> tags;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        images,
        categories,
        discounts,
        attributes,
        metadata,
        specs,
        tags,
      ];

  Product copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    List<String>? images,
    List<Category>? categories,
    List<Discount>? discounts,
    List<KeyValueAttribute>? attributes,
    Map<String, dynamic>? metadata,
    List<SpecAttribute>? specs,
    List<ProductTag>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      categories: categories ?? this.categories,
      discounts: discounts ?? this.discounts,
      attributes: attributes ?? this.attributes,
      metadata: metadata ?? this.metadata,
      specs: specs ?? this.specs,
      tags: tags ?? this.tags,
    );
  }

  OrderQuantity get orderQuantity => metadata != null
      ? OrderQuantity.fromJson(metadata!['order_quantity'])
      : OrderQuantity();

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, images: $images, categories: $categories, discounts: $discounts, attributes: $attributes, metadata: $metadata, specs: $specs, tags: $tags)';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
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
        attributes: (json['attributes'] as List<dynamic>?)
                ?.map((e) =>
                    KeyValueAttribute.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        metadata: json['metadata'] as Map<String, dynamic>?,
        specs: (json['attribute_options'] as List<dynamic>?)
                ?.map((e) => SpecAttribute.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => ProductTag.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'images': images,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'discounts': discounts?.map((e) => e.toJson()).toList(),
        'attributes': attributes.map((e) => e.toJson()).toList(),
        'metadata': metadata,
        'specs': specs.map((e) => e.toJson()).toList(),
        'tags': tags.map((e) => e.toJson()).toList(),
      };

  String toCartQL() => '''{
    id: "$id"
    name: "$name"
    description: "$description"
    price: $price
    images: ${jsonEncode(images)}
    specs: [${specs.isNotEmpty ? specs.map((e) => e.toCartQL()).join(',') : ''}]
  }''';

  String toAddItemCartQL({required String cartId, int quantity = 1}) => '''
    mutation {
      addItem(
        input: {
          cartId: "$cartId"
          id: "$id"
          name: "$name"
          type: SKU
          description: "$description"
          images: ${jsonEncode(images)}
          price: $price
          quantity: $quantity
          attributes: [
            ${attributes.map((e) => e.toCartQL()).join(',')}
          ]
          metadata: {
            ${orderQuantity.toCartQL()}
            discounts: [
              ${discounts != null && discounts!.isNotEmpty ? (discounts ?? []).map((e) => e.toCartQL()).join(',') : ''}
            ]
            categories: [
              ${categories != null && categories!.isNotEmpty ? (categories ?? []).map((e) => e.toCartQL()).join(',') : ''}
            ]
            specs: [
              ${specs.isNotEmpty ? specs.map((e) => e.toCartQL()).join(',') : ''}
            ]
            tags: [
              ${tags.isNotEmpty ? tags.map((e) => e.toCartQL()).join(',') : ''}
            ]
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
