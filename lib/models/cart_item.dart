import 'package:demo/models/all.dart';
import 'package:equatable/equatable.dart';

class NameValueAttribute {
  final String name;
  final String value;

  const NameValueAttribute({
    required this.name,
    required this.value,
  });

  NameValueAttribute.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
      };

  String toCartQL() => '''
    {
      name: "$name",
      value: "$value"
    }
  ''';

  @override
  String toString() {
    return 'CartItemAttribute{name: $name, value: $value}';
  }

  NameValueAttribute copyWith({
    String? name,
    String? value,
  }) {
    return NameValueAttribute(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}

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
  final List<NameValueAttribute> attributes;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  });

  CartItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['id'],
        name = json['name'],
        description = json['description'],
        type = CartItemType.values.firstWhere(
            (element) => element.value == json['type'],
            orElse: () => CartItemType.sku),
        images = List<String>.from(json['images']),
        unitTotal = Money.fromJson(json['unitTotal']),
        lineTotal = Money.fromJson(json['lineTotal']),
        quantity = json['quantity'],
        metadata = json['metadata'],
        attributes = List<NameValueAttribute>.from(
            json['attributes'].map((x) => NameValueAttribute.fromJson(x))),
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

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
        'metadata': metadata,
        'attributes': attributes.map((x) => x.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
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
    List<NameValueAttribute>? attributes,
    DateTime? createdAt,
    DateTime? updatedAt,
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
    );
  }
}
