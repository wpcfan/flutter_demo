import 'package:demo/models/all.dart';
import 'package:demo/models/currency.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String id;
  final Currency currency;
  final String? email;
  final String? mobile;
  final int totalItems;
  final int totalUniqueItems;
  final List<CartItem> items;
  final Money subTotal;
  final Money shippingTotal;
  final Money taxTotal;
  final Money grandTotal;
  final bool isEmpty;
  final bool abandoned;
  final List<NameValueAttribute> attributes;
  final Map<String, dynamic>? metadata;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Cart({
    required this.id,
    required this.currency,
    this.email,
    this.mobile,
    required this.totalItems,
    required this.totalUniqueItems,
    required this.items,
    required this.subTotal,
    required this.shippingTotal,
    required this.taxTotal,
    required this.grandTotal,
    required this.isEmpty,
    required this.abandoned,
    required this.attributes,
    this.metadata,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        currency = Currency.fromJson(json['currency']),
        email = json['email'],
        mobile = json['mobile'],
        totalItems = json['totalItems'],
        totalUniqueItems = json['totalUniqueItems'],
        items =
            (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
        subTotal = Money.fromJson(json['subTotal']),
        shippingTotal = Money.fromJson(json['shippingTotal']),
        taxTotal = Money.fromJson(json['taxTotal']),
        grandTotal = Money.fromJson(json['grandTotal']),
        isEmpty = json['isEmpty'],
        abandoned = json['abandoned'],
        attributes = (json['attributes'] as List)
            .map((e) => NameValueAttribute.fromJson(e))
            .toList(),
        metadata = json['metadata'],
        notes = json['notes'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'currency': currency.toJson(),
        'email': email,
        'mobile': mobile,
        'totalItems': totalItems,
        'totalUniqueItems': totalUniqueItems,
        'items': items.map((e) => e.toJson()).toList(),
        'subTotal': subTotal.toJson(),
        'shippingTotal': shippingTotal.toJson(),
        'taxTotal': taxTotal.toJson(),
        'grandTotal': grandTotal.toJson(),
        'isEmpty': isEmpty,
        'abandoned': abandoned,
        'attributes': attributes.map((e) => e.toJson()).toList(),
        'metadata': metadata,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  Cart copyWith({
    String? id,
    Currency? currency,
    String? email,
    String? mobile,
    int? totalItems,
    int? totalUniqueItems,
    List<CartItem>? items,
    Money? subTotal,
    Money? shippingTotal,
    Money? taxTotal,
    Money? grandTotal,
    bool? isEmpty,
    bool? abandoned,
    List<NameValueAttribute>? attributes,
    Map<String, dynamic>? metadata,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Cart(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      totalItems: totalItems ?? this.totalItems,
      totalUniqueItems: totalUniqueItems ?? this.totalUniqueItems,
      items: items ?? this.items,
      subTotal: subTotal ?? this.subTotal,
      shippingTotal: shippingTotal ?? this.shippingTotal,
      taxTotal: taxTotal ?? this.taxTotal,
      grandTotal: grandTotal ?? this.grandTotal,
      isEmpty: isEmpty ?? this.isEmpty,
      abandoned: abandoned ?? this.abandoned,
      attributes: attributes ?? this.attributes,
      metadata: metadata ?? this.metadata,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      currency,
      email,
      mobile,
      totalItems,
      totalUniqueItems,
      items,
      subTotal,
      shippingTotal,
      taxTotal,
      grandTotal,
      isEmpty,
      abandoned,
      attributes,
      metadata,
      notes,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'Cart(id: $id, currency: $currency, email: $email, mobile: $mobile, totalItems: $totalItems, items: $items, subTotal: $subTotal, shippingTotal: $shippingTotal, taxTotal: $taxTotal, grandTotal: $grandTotal, isEmpty: $isEmpty, abandoned: $abandoned, attributes: $attributes, metadata: $metadata, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
