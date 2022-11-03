import 'package:demo/forms/validator_helper.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'user.gform.dart';

@ReactiveFormAnnotation()
class User {
  final String username;
  final String password;
  final String phone;
  String? objectId;
  String? sessionToken;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool? emailVerified;
  bool? mobilePhoneVerified;

  User(
    @FormControlAnnotation(validators: [requiredValidator]) this.username,
    @FormControlAnnotation(validators: [requiredValidator]) this.password,
    @FormControlAnnotation(validators: [requiredValidator]) this.phone,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'] as String,
      json['password'] as String,
      json['phone'] as String,
    )
      ..objectId = json['objectId'] as String?
      ..sessionToken = json['sessionToken'] as String?
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String)
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String)
      ..emailVerified = json['emailVerified'] as bool?
      ..mobilePhoneVerified = json['mobilePhoneVerified'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['phone'] = phone;
    data['objectId'] = objectId;
    data['sessionToken'] = sessionToken;
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['createdAt'] = createdAt?.toIso8601String();
    data['emailVerified'] = emailVerified;
    data['mobilePhoneVerified'] = mobilePhoneVerified;
    return data;
  }
}
