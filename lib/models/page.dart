import 'package:equatable/equatable.dart';

enum PageBlockType {
  slider,
}

enum LinkType {
  url,
  route,
  deepLink,
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
      type: LinkType.values.firstWhere((e) => e.toString() == json['type']),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'value': value,
    };
  }
}

abstract class PageBlock extends Equatable {
  const PageBlock({
    required this.id,
    required this.type,
    required this.sort,
  });
  final int id;
  final PageBlockType type;
  final int sort;

  factory PageBlock.fromJson(Map<String, dynamic> json) {
    final type =
        PageBlockType.values.firstWhere((e) => e.toString() == json['type']);
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
  final double? width;
  final double? height;

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
  final double? width;
  final double? height;
  final List<ImageData> data;

  const SliderPageBlock({
    required int id,
    required int sort,
    required this.data,
    this.title,
    this.width,
    this.height,
  }) : super(id: id, type: PageBlockType.slider, sort: sort);

  @override
  List<Object?> get props => [id, type, sort, data, title, width, height];

  factory SliderPageBlock.fromJson(Map<String, dynamic> json) {
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
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'sort': sort,
      'data': data.map((e) => e.toJson()).toList(),
      'title': title,
      'width': width,
      'height': height,
    };
  }
}
