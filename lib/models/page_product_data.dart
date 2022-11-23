part of 'page.dart';

class ProductData extends Equatable {
  final int sort;
  final String id;
  final String name;
  final String description;
  final String price;
  final String? originalPrice;
  final String image;

  const ProductData({
    required this.sort,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.image,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      sort: json['sort'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      originalPrice: json['originalPrice'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sort': sort,
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'image': image,
    };
  }

  @override
  List<Object?> get props =>
      [sort, id, name, description, price, originalPrice, image];
}
