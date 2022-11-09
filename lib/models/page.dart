import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum PageBlockType {
  slider('slider'),
  ;

  final String value;
  const PageBlockType(this.value);
}

enum LinkType {
  url('url'),
  route('route'),
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
