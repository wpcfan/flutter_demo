import 'package:demo/models/address_input.dart';

class CheckoutInput {
  final int cartId;
  final String? email;
  final String? mobile;
  final String? notes;
  final AddressInput shipping;
  final AddressInput billing;
  final Map<String, dynamic>? metadata;

  const CheckoutInput({
    required this.cartId,
    this.email,
    this.mobile,
    this.notes,
    required this.shipping,
    required this.billing,
    this.metadata,
  });

  CheckoutInput.fromJson(Map<String, dynamic> json)
      : cartId = json['cartId'],
        email = json['email'],
        mobile = json['mobile'],
        notes = json['notes'],
        shipping = AddressInput.fromJson(json['shipping']),
        billing = AddressInput.fromJson(json['billing']),
        metadata = json['metadata'];

  Map<String, dynamic> toJson() => {
        'cartId': cartId,
        'email': email,
        'mobile': mobile,
        'notes': notes,
        'shipping': shipping.toJson(),
        'billing': billing.toJson(),
        'metadata': metadata,
      };

  @override
  String toString() {
    return 'CheckoutInput{cartId: $cartId, email: $email, mobile: $mobile, notes: $notes, shipping: $shipping, billing: $billing, metadata: $metadata}';
  }

  CheckoutInput copyWith({
    int? cartId,
    String? email,
    String? mobile,
    String? notes,
    AddressInput? shipping,
    AddressInput? billing,
    Map<String, dynamic>? metadata,
  }) {
    return CheckoutInput(
      cartId: cartId ?? this.cartId,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      notes: notes ?? this.notes,
      shipping: shipping ?? this.shipping,
      billing: billing ?? this.billing,
      metadata: metadata ?? this.metadata,
    );
  }
}
