import 'dart:convert';

import 'package:demo/models/all.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String? productId;
  final String name;
  final String description;
  final CartItemType type;
  final List<String> images;
  final Money unitTotal;
  final Money lineTotal;
  final int quantity;
  final Map<String, dynamic>? metadata;
  final List<KeyValueAttribute> attributes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSelected;

  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.type,
    required this.images,
    required this.unitTotal,
    required this.lineTotal,
    required this.quantity,
    this.metadata,
    required this.attributes,
    required this.createdAt,
    required this.updatedAt,
    this.isSelected = false,
  });

  List<Discount> get discounts =>
      ((metadata?['discounts'] ?? []) as List<dynamic>)
          .map((it) => Discount.fromJson(it as Map<String, dynamic>))
          .toList();

  List<Category> get categories =>
      ((metadata?['categories'] ?? []) as List<dynamic>)
          .map((it) => Category.fromJson(it as Map<String, dynamic>))
          .toList();

  OrderQuantity get orderQuantity => metadata?['orderQuantity'] != null
      ? OrderQuantity.fromJson(metadata?['orderQuantity'])
      : OrderQuantity();

  List<ProductTag> get tags => ((metadata?['tags'] ?? []) as List<dynamic>)
      .map((it) => ProductTag.fromJson(it as Map<String, dynamic>))
      .toList();

  List<SpecAttribute> get specs => ((metadata?['specs'] ?? []) as List<dynamic>)
      .map((it) => SpecAttribute.fromJson(it as Map<String, dynamic>))
      .toList();

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      description: json['description'],
      type: CartItemType.values.firstWhere((e) => e.value == json['type'],
          orElse: () => CartItemType.sku),
      images: List<String>.from(json['images']),
      unitTotal: Money.fromJson(json['unitTotal']),
      lineTotal: Money.fromJson(json['lineTotal']),
      quantity: json['quantity'],
      metadata: json['metadata'],
      attributes: List<KeyValueAttribute>.from(
          json['attributes'].map((x) => KeyValueAttribute.fromJson(x))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isSelected: json['metadata']?['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'name': name,
        'description': description,
        'type': type.index,
        'images': images,
        'unitTotal': unitTotal.toJson(),
        'lineTotal': lineTotal.toJson(),
        'quantity': quantity,
        'metadata': jsonEncode(metadata),
        'attributes': attributes.map((x) => x.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'isSelected': isSelected,
      };

  @override
  List<Object?> get props {
    return [
      id,
      productId,
      name,
      description,
      type,
      images,
      unitTotal,
      lineTotal,
      quantity,
      metadata,
      attributes,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'CartItem{id: $id, productId: $productId, name: $name, description: $description, type: $type, images: $images, unitTotal: $unitTotal, lineTotal: $lineTotal, quantity: $quantity, metadata: $metadata, attributes: $attributes, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? description,
    CartItemType? type,
    List<String>? images,
    Money? unitTotal,
    Money? lineTotal,
    int? quantity,
    Map<String, dynamic>? metadata,
    List<KeyValueAttribute>? attributes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSelected,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      images: images ?? this.images,
      unitTotal: unitTotal ?? this.unitTotal,
      lineTotal: lineTotal ?? this.lineTotal,
      quantity: quantity ?? this.quantity,
      metadata: metadata ?? this.metadata,
      attributes: attributes ?? this.attributes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
