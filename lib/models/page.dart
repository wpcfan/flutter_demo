import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum PageBlockType {
  slider('slider'),
  imageRow('image_row'),
  productRow('product_row'),
  waterfall('waterfall'),
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
  });
  final int id;
  final PageBlockType type;
  final int sort;
  final String platform;

  factory PageBlock.fromJson(Map<String, dynamic> json) {
    final type =
        PageBlockType.values.firstWhere((e) => e.value == json['type']);
    switch (type) {
      case PageBlockType.slider:
        return SliderPageBlock.fromJson(json);
      case PageBlockType.imageRow:
        return ImageRowPageBlock.fromJson(json);
      case PageBlockType.productRow:
        return ProductRowPageBlock.fromJson(json);
      case PageBlockType.waterfall:
        return WaterfallPageBlock.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

class ImageData extends Equatable {
  const ImageData({
    required this.image,
    required this.link,
    required this.sort,
    this.title,
    this.width,
    this.height,
  });

  final String image;
  final Link link;
  final int sort;
  final String? title;
  final int? width;
  final int? height;

  factory ImageData.fromJson(Map<String, dynamic> json) {
    debugPrint('ImageData.fromJson: $json');
    return ImageData(
      image: json['image'],
      link: Link.fromJson(json['link']),
      sort: json['sort'],
      title: json['title'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'link': link.toJson(),
      'sort': sort,
      'title': title,
      'width': width,
      'height': height,
    };
  }

  @override
  List<Object?> get props => [image, link, sort, title, width, height];
}

class SliderPageBlock extends PageBlock {
  final String? title;
  final int? width;
  final int? height;
  final List<ImageData> data;

  const SliderPageBlock({
    required int id,
    required int sort,
    required String platform,
    this.title,
    this.width,
    this.height,
    required this.data,
  }) : super(
          id: id,
          type: PageBlockType.slider,
          sort: sort,
          platform: platform,
        );

  @override
  List<Object?> get props =>
      [id, type, sort, data, title, width, height, platform];

  factory SliderPageBlock.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return SliderPageBlock(
      id: json['id'],
      sort: json['sort'],
      data: (json['data'] as List)
          .map((e) => ImageData.fromJson(e))
          .toList()
          .cast<ImageData>(),
      title: json['title'],
      width: json['width'],
      height: json['height'],
      platform: json['platform'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'sort': sort,
      'data': data.map((e) => e.toJson()).toList(),
      'title': title,
      'width': width,
      'height': height,
      'platform': platform,
    };
  }
}

class ImageRowPageBlock extends PageBlock {
  final String? title;
  final int? width;
  final int? height;
  final List<ImageData> data;

  const ImageRowPageBlock({
    required int id,
    required int sort,
    required String platform,
    this.title,
    this.width,
    this.height,
    required this.data,
  }) : super(
          id: id,
          type: PageBlockType.imageRow,
          sort: sort,
          platform: platform,
        );

  @override
  List<Object?> get props =>
      [id, type, sort, data, title, width, height, platform];

  factory ImageRowPageBlock.fromJson(Map<String, dynamic> json) {
    return ImageRowPageBlock(
      id: json['id'],
      sort: json['sort'],
      data: (json['data'] as List)
          .map((e) => ImageData.fromJson(e))
          .toList()
          .cast<ImageData>(),
      title: json['title'],
      width: json['width'],
      height: json['height'],
      platform: json['platform'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'sort': sort,
      'data': data.map((e) => e.toJson()).toList(),
      'title': title,
      'width': width,
      'height': height,
      'platform': platform,
    };
  }
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

class ProductRowPageBlock extends PageBlock {
  final int? width;
  final int? height;
  final List<ProductData> data;

  const ProductRowPageBlock({
    required int id,
    required int sort,
    required String platform,
    this.width,
    this.height,
    required this.data,
  }) : super(
          id: id,
          type: PageBlockType.productRow,
          sort: sort,
          platform: platform,
        );

  @override
  List<Object?> get props => [id, type, sort, data, width, height, platform];

  factory ProductRowPageBlock.fromJson(Map<String, dynamic> json) {
    return ProductRowPageBlock(
      id: json['id'],
      sort: json['sort'],
      data: (json['data'] as List)
          .map((e) => ProductData.fromJson(e))
          .toList()
          .cast<ProductData>(),
      width: json['width'],
      height: json['height'],
      platform: json['platform'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'sort': sort,
      'data': data.map((e) => e.toJson()).toList(),
      'width': width,
      'height': height,
      'platform': platform,
    };
  }
}

enum WaterfallDataType {
  category('category'),
  product('product'),
  ;

  final String value;

  const WaterfallDataType(this.value);
}

class WaterfallData extends Equatable {
  final String title;
  final List<ProductData> data;
  const WaterfallData(this.title, this.data);

  @override
  List<Object?> get props => [title, data];

  factory WaterfallData.fromJson(Map<String, dynamic> json) {
    return WaterfallData(
      json['title'],
      (json['data'] as List)
          .map((e) => ProductData.fromJson(e))
          .toList()
          .cast<ProductData>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class WaterfallPageBlock extends PageBlock {
  final int? width;
  final int? height;
  final List<WaterfallData> data;

  const WaterfallPageBlock({
    required int id,
    required int sort,
    required String platform,
    this.width,
    this.height,
    required this.data,
  }) : super(
          id: id,
          type: PageBlockType.waterfall,
          sort: sort,
          platform: platform,
        );

  @override
  List<Object?> get props => [id, type, sort, data, width, height, platform];

  factory WaterfallPageBlock.fromJson(Map<String, dynamic> json) {
    return WaterfallPageBlock(
      id: json['id'],
      sort: json['sort'],
      data: (json['data'] as List)
          .map((e) => WaterfallData.fromJson(e))
          .toList()
          .cast<WaterfallData>(),
      width: json['width'],
      height: json['height'],
      platform: json['platform'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'sort': sort,
      'data': data.map((e) => e.toJson()).toList(),
      'width': width,
      'height': height,
      'platform': platform,
    };
  }
}
