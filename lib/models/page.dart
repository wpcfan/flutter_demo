import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'page_category_ranking.dart';
part 'page_image_row.dart';
part 'page_pinned_header.dart';
part 'page_product_row.dart';
part 'page_slider.dart';
part 'page_waterfall.dart';

enum PageBlockType {
  pinnedHeader('pinned_header'),
  slider('slider'),
  imageRow('image_row'),
  productRow('product_row'),
  waterfall('waterfall'),
  categoryRanking('category_ranking'),
  ;

  final String value;
  const PageBlockType(this.value);
}

enum LinkType {
  url('url'),
  deepLink('deep_link'),
  ;

  final String value;
  const LinkType(this.value);
}

class Link extends Equatable {
  const Link({
    required this.type,
    required this.value,
  });

  final LinkType type;
  final String value;

  @override
  List<Object?> get props => [type, value];

  factory Link.fromJson(Map<String, dynamic> json) {
    debugPrint('Link.fromJson: $json');
    return Link(
      type: LinkType.values.firstWhere((e) => e.value == json['type']),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      'value': value,
    };
  }
}

abstract class PageBlock extends Equatable {
  const PageBlock({
    required this.id,
    required this.type,
    required this.sort,
    required this.platform,
    required this.target,
  });
  final int id;
  final PageBlockType type;
  final int sort;
  final String platform;
  final String target;

  factory PageBlock.fromJson(Map<String, dynamic> json) {
    final type =
        PageBlockType.values.firstWhere((e) => e.value == json['type']);
    switch (type) {
      case PageBlockType.pinnedHeader:
        return PinnedHeaderPageBlock.fromJson(json);
      case PageBlockType.slider:
        return SliderPageBlock.fromJson(json);
      case PageBlockType.imageRow:
        return ImageRowPageBlock.fromJson(json);
      case PageBlockType.productRow:
        return ProductRowPageBlock.fromJson(json);
      case PageBlockType.waterfall:
        return WaterfallPageBlock.fromJson(json);
      case PageBlockType.categoryRanking:
        return CategoryRankingPageBlock.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

class ImageData extends Equatable {
  const ImageData({
    required this.image,
    required this.sort,
    this.link,
    this.title,
    this.width,
    this.height,
  });

  final String image;
  final Link? link;
  final int sort;
  final String? title;
  final int? width;
  final int? height;

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      image: json['image'],
      link: json['link'] != null ? Link.fromJson(json['link']) : null,
      sort: json['sort'],
      title: json['title'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'link': link?.toJson(),
      'sort': sort,
      'title': title,
      'width': width,
      'height': height,
    };
  }

  @override
  List<Object?> get props => [image, link, sort, title, width, height];
}

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
