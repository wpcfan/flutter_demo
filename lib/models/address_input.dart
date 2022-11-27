import 'package:equatable/equatable.dart';

class AddressInput extends Equatable {
  final String? company;
  final String name;
  final String line1;
  final String? line2;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const AddressInput({
    this.company,
    required this.name,
    required this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  AddressInput.fromJson(Map<String, dynamic> json)
      : company = json['company'],
        name = json['name'],
        line1 = json['line1'],
        line2 = json['line2'],
        city = json['city'],
        state = json['state'],
        postalCode = json['postalCode'],
        country = json['country'];

  Map<String, dynamic> toJson() => {
        'company': company,
        'name': name,
        'line1': line1,
        'line2': line2,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
      };

  @override
  List<Object?> get props => [
        company,
        name,
        line1,
        line2,
        city,
        state,
        postalCode,
        country,
      ];

  @override
  String toString() {
    return 'AddressInput{company: $company, name: $name, line1: $line1, line2: $line2, city: $city, state: $state, postalCode: $postalCode, country: $country}';
  }

  AddressInput copyWith({
    String? company,
    String? name,
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    return AddressInput(
      company: company ?? this.company,
      name: name ?? this.name,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }
}
