import 'package:equatable/equatable.dart';

enum DiscountType {
  discount('discount'),
  discountOnUnit('discount_on_unit'),
  discountOnTotal('discount_on_total'),
  discountEveryXUnit('discount_every_x_unit'),
  discountEveryXTotal('discount_every_x_total'),
  freeProduct('free_product'),
  freeProductOnUnit('free_product_on_unit'),
  freeProductOnTotal('free_product_on_total'),
  freeProductEveryXUnit('free_product_every_x_unit'),
  freeProductEveryXTotal('free_product_every_x_total'),
  buyXGetY('buy_x_get_y'),
  flashSale('flash_sale'),
  ;

  final String value;
  const DiscountType(this.value);
}

abstract class Discount extends Equatable {
  final int id;
  final String title;
  final DiscountType type;
  final String tag;
  final String titleWhenApplied;

  const Discount({
    required this.id,
    required this.title,
    required this.type,
    required this.tag,
    required this.titleWhenApplied,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    final type = DiscountType.values.firstWhere((e) => e.value == json['type']);
    switch (type) {
      case DiscountType.discount:
        return DiscountPromotion.fromJson(json);
      case DiscountType.discountOnUnit:
        return DiscountOnUnitPromotion.fromJson(json);
      case DiscountType.discountOnTotal:
        return DiscountOnTotalPromotion.fromJson(json);
      case DiscountType.discountEveryXUnit:
        return DiscountEveryXUnitPromotion.fromJson(json);
      case DiscountType.discountEveryXTotal:
        return DiscountEveryXTotalPromotion.fromJson(json);
      case DiscountType.freeProduct:
        return FreeProductPromotion.fromJson(json);
      case DiscountType.freeProductOnUnit:
        return FreeProductOnUnitPromotion.fromJson(json);
      case DiscountType.freeProductOnTotal:
        return FreeProductOnTotalPromotion.fromJson(json);
      case DiscountType.freeProductEveryXUnit:
        return FreeProductEveryXUnitPromotion.fromJson(json);
      case DiscountType.freeProductEveryXTotal:
        return FreeProductEveryXTotalPromotion.fromJson(json);
      case DiscountType.buyXGetY:
        return BuyXGetYPromotion.fromJson(json);
      case DiscountType.flashSale:
        return FlashSalePromotion.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

/// Discount
class DiscountPromotion extends Discount {
  final String discount;

  const DiscountPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.discount,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.discount,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [id, title, type, tag, titleWhenApplied, discount];

  @override
  String toString() {
    return '''DiscountPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        discount: $discount,
      }''';
  }

  DiscountPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? discount,
  }) {
    return DiscountPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      discount: discount ?? this.discount,
    );
  }

  factory DiscountPromotion.fromJson(Map<String, dynamic> json) =>
      DiscountPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        discount: json["discount"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "discount": discount,
      };
}

/// Free Product on purchase
class FreeProductPromotion extends Discount {
  final String productId;
  final String productName;
  final String productImage;
  final String productPrice;

  const FreeProductPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.freeProduct,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        productId,
        productName,
        productImage,
        productPrice,
      ];

  @override
  String toString() {
    return '''FreeProductPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        productId: $productId,
        productName: $productName,
        productImage: $productImage,
        productPrice: $productPrice,
      }''';
  }

  FreeProductPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? productId,
    String? productName,
    String? productImage,
    String? productPrice,
  }) {
    return FreeProductPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  factory FreeProductPromotion.fromJson(Map<String, dynamic> json) =>
      FreeProductPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
      };
}

/// Buy X Get Y
/// note: X and Y are the same product
class BuyXGetYPromotion extends Discount {
  final String productId;
  final String productName;
  final String productImage;
  final String productPrice;
  final int buy;
  final int get;

  const BuyXGetYPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.buy,
    required this.get,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.buyXGetY,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        productId,
        productName,
        productImage,
        productPrice,
        buy,
        get,
      ];

  @override
  String toString() {
    return '''BuyXGetYPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        productId: $productId,
        productName: $productName,
        productImage: $productImage,
        productPrice: $productPrice,
        buy: $buy,
        get: $get,
      }''';
  }

  BuyXGetYPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? productId,
    String? productName,
    String? productImage,
    String? productPrice,
    int? buy,
    int? get,
  }) {
    return BuyXGetYPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      buy: buy ?? this.buy,
      get: get ?? this.get,
    );
  }

  factory BuyXGetYPromotion.fromJson(Map<String, dynamic> json) =>
      BuyXGetYPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
        buy: json["buy"],
        get: json["get"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
        "buy": buy,
        "get": get,
      };
}

/// Discount based on the quantity of the product
/// NOTE: the condition is NOT repeated,
/// i.e. if the quantity of the product in cart is 5 and minQuantity is 3,
/// then the discount is applied only once
class DiscountOnUnitPromotion extends Discount {
  final String discount;
  final int minQuantity;

  const DiscountOnUnitPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.discount,
    required this.minQuantity,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.discountOnUnit,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props =>
      [id, title, type, tag, titleWhenApplied, discount, minQuantity];

  @override
  String toString() {
    return '''DiscountOnMultiplePromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        discount: $discount,
        minQuantity: $minQuantity,
      }''';
  }

  DiscountOnUnitPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? discount,
    int? minQuantity,
  }) {
    return DiscountOnUnitPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      discount: discount ?? this.discount,
      minQuantity: minQuantity ?? this.minQuantity,
    );
  }

  factory DiscountOnUnitPromotion.fromJson(Map<String, dynamic> json) =>
      DiscountOnUnitPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        discount: json["discount"],
        minQuantity: json["minQuantity"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "discount": discount,
        "minQuantity": minQuantity,
      };
}

/// Discount based on the total price of the product
/// NOTE: the condition is NOT repeated,
/// i.e. if the total price of the product in cart is 5 and minPrice is 3,
/// then the discount is applied only once
class DiscountOnTotalPromotion extends Discount {
  final String discount;
  final int minTotal;

  const DiscountOnTotalPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.discount,
    required this.minTotal,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.discountOnTotal,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [id, title, type, tag, titleWhenApplied, discount];

  @override
  String toString() {
    return '''DiscountOnTotalPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        discount: $discount,
        minTotal: $minTotal,
      }''';
  }

  DiscountOnTotalPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? discount,
    int? minTotal,
  }) {
    return DiscountOnTotalPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      discount: discount ?? this.discount,
      minTotal: minTotal ?? this.minTotal,
    );
  }

  factory DiscountOnTotalPromotion.fromJson(Map<String, dynamic> json) =>
      DiscountOnTotalPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        discount: json["discount"],
        minTotal: json["minTotal"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "discount": discount,
        "minTotal": minTotal,
      };
}

/// Discount based on the quantity of the product
/// NOTE: the condition is repeated,
/// i.e. if the quantity of the product in cart is 6 and minQuantity is 3,
/// then the discount is applied 2 times
class DiscountEveryXUnitPromotion extends Discount {
  final String discount;
  final int everyXUnit;

  const DiscountEveryXUnitPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.discount,
    required this.everyXUnit,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.discountEveryXUnit,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props =>
      [id, title, type, tag, titleWhenApplied, discount, everyXUnit];

  @override
  String toString() {
    return '''DiscountOnEveryXUnitPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        discount: $discount,
        everyXUnit: $everyXUnit,
      }''';
  }

  DiscountEveryXUnitPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? discount,
    int? everyXUnit,
  }) {
    return DiscountEveryXUnitPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      discount: discount ?? this.discount,
      everyXUnit: everyXUnit ?? this.everyXUnit,
    );
  }

  factory DiscountEveryXUnitPromotion.fromJson(Map<String, dynamic> json) =>
      DiscountEveryXUnitPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        discount: json["discount"],
        everyXUnit: json["everyXUnit"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "discount": discount,
        "everyXUnit": everyXUnit,
      };
}

/// Discount based on the total price of the product
/// NOTE: the condition is repeated,
/// i.e. if the total price of the product in cart is 6 and minTotal is 3,
/// then the discount is applied 2 times
class DiscountEveryXTotalPromotion extends Discount {
  final String discount;
  final int everyXTotal;

  const DiscountEveryXTotalPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.discount,
    required this.everyXTotal,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.discountEveryXTotal,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props =>
      [id, title, type, tag, titleWhenApplied, discount, everyXTotal];

  @override
  String toString() {
    return '''DiscountOnEveryXTotalPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        discount: $discount,
        everyXTotal: $everyXTotal,
      }''';
  }

  DiscountEveryXTotalPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? discount,
    int? everyXTotal,
  }) {
    return DiscountEveryXTotalPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      discount: discount ?? this.discount,
      everyXTotal: everyXTotal ?? this.everyXTotal,
    );
  }

  factory DiscountEveryXTotalPromotion.fromJson(Map<String, dynamic> json) =>
      DiscountEveryXTotalPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        discount: json["discount"],
        everyXTotal: json["everyXTotal"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "discount": discount,
        "everyXTotal": everyXTotal,
      };
}

class FreeProductOnUnitPromotion extends Discount {
  final String freeProductId;
  final String freeProductName;
  final String freeProductImage;
  final String freeProductPrice;
  final int minQuantity;

  const FreeProductOnUnitPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.freeProductId,
    required this.freeProductName,
    required this.freeProductImage,
    required this.freeProductPrice,
    required this.minQuantity,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.freeProductOnUnit,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        freeProductId,
        freeProductName,
        freeProductImage,
        freeProductPrice,
        minQuantity,
      ];

  @override
  String toString() {
    return '''FreeProductOnUnitPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        freeProductId: $freeProductId,
        freeProductName: $freeProductName,
        freeProductImage: $freeProductImage,
        freeProductPrice: $freeProductPrice,
        minQuantity: $minQuantity,
      }''';
  }

  FreeProductOnUnitPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? freeProductId,
    String? freeProductName,
    String? freeProductImage,
    String? freeProductPrice,
    int? minQuantity,
  }) {
    return FreeProductOnUnitPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      freeProductId: freeProductId ?? this.freeProductId,
      freeProductName: freeProductName ?? this.freeProductName,
      freeProductImage: freeProductImage ?? this.freeProductImage,
      freeProductPrice: freeProductPrice ?? this.freeProductPrice,
      minQuantity: minQuantity ?? this.minQuantity,
    );
  }

  factory FreeProductOnUnitPromotion.fromJson(Map<String, dynamic> json) =>
      FreeProductOnUnitPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        freeProductId: json["freeProductId"],
        freeProductName: json["freeProductName"],
        freeProductImage: json["freeProductImage"],
        freeProductPrice: json["freeProductPrice"],
        minQuantity: json["minQuantity"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "freeProductId": freeProductId,
        "freeProductName": freeProductName,
        "freeProductImage": freeProductImage,
        "freeProductPrice": freeProductPrice,
        "minQuantity": minQuantity,
      };
}

class FreeProductOnTotalPromotion extends Discount {
  final String freeProductId;
  final String freeProductName;
  final String freeProductImage;
  final String freeProductPrice;
  final int minTotal;

  const FreeProductOnTotalPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.freeProductId,
    required this.freeProductName,
    required this.freeProductImage,
    required this.freeProductPrice,
    required this.minTotal,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.freeProductOnTotal,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        freeProductId,
        freeProductName,
        freeProductImage,
        freeProductPrice,
        minTotal,
      ];

  @override
  String toString() {
    return '''FreeProductOnTotalPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        freeProductId: $freeProductId,
        freeProductName: $freeProductName,
        freeProductImage: $freeProductImage,
        freeProductPrice: $freeProductPrice,
        minTotal: $minTotal,
      }''';
  }

  FreeProductOnTotalPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? freeProductId,
    String? freeProductName,
    String? freeProductImage,
    String? freeProductPrice,
    int? minTotal,
  }) {
    return FreeProductOnTotalPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      freeProductId: freeProductId ?? this.freeProductId,
      freeProductName: freeProductName ?? this.freeProductName,
      freeProductImage: freeProductImage ?? this.freeProductImage,
      freeProductPrice: freeProductPrice ?? this.freeProductPrice,
      minTotal: minTotal ?? this.minTotal,
    );
  }

  factory FreeProductOnTotalPromotion.fromJson(Map<String, dynamic> json) =>
      FreeProductOnTotalPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        freeProductId: json["freeProductId"],
        freeProductName: json["freeProductName"],
        freeProductImage: json["freeProductImage"],
        freeProductPrice: json["freeProductPrice"],
        minTotal: json["minTotal"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "freeProductId": freeProductId,
        "freeProductName": freeProductName,
        "freeProductImage": freeProductImage,
        "freeProductPrice": freeProductPrice,
        "minTotal": minTotal,
      };
}

class FreeProductEveryXUnitPromotion extends Discount {
  final String freeProductId;
  final String freeProductName;
  final String freeProductImage;
  final String freeProductPrice;
  final int everyXUnit;

  const FreeProductEveryXUnitPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.freeProductId,
    required this.freeProductName,
    required this.freeProductImage,
    required this.freeProductPrice,
    required this.everyXUnit,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.freeProductEveryXUnit,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        freeProductId,
        freeProductName,
        freeProductImage,
        freeProductPrice,
        everyXUnit,
      ];

  @override
  String toString() {
    return '''FreeProductEveryXUnitPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        freeProductId: $freeProductId,
        freeProductName: $freeProductName,
        freeProductImage: $freeProductImage,
        freeProductPrice: $freeProductPrice,
        everyXUnit: $everyXUnit,
      }''';
  }

  FreeProductEveryXUnitPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? freeProductId,
    String? freeProductName,
    String? freeProductImage,
    String? freeProductPrice,
    int? everyXUnit,
  }) {
    return FreeProductEveryXUnitPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      freeProductId: freeProductId ?? this.freeProductId,
      freeProductName: freeProductName ?? this.freeProductName,
      freeProductImage: freeProductImage ?? this.freeProductImage,
      freeProductPrice: freeProductPrice ?? this.freeProductPrice,
      everyXUnit: everyXUnit ?? this.everyXUnit,
    );
  }

  factory FreeProductEveryXUnitPromotion.fromJson(Map<String, dynamic> json) =>
      FreeProductEveryXUnitPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        freeProductId: json["freeProductId"],
        freeProductName: json["freeProductName"],
        freeProductImage: json["freeProductImage"],
        freeProductPrice: json["freeProductPrice"],
        everyXUnit: json["everyXUnit"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "freeProductId": freeProductId,
        "freeProductName": freeProductName,
        "freeProductImage": freeProductImage,
        "freeProductPrice": freeProductPrice,
        "everyXUnit": everyXUnit,
      };
}

class FreeProductEveryXTotalPromotion extends Discount {
  final String freeProductId;
  final String freeProductName;
  final String freeProductImage;
  final String freeProductPrice;
  final int everyXTotal;

  const FreeProductEveryXTotalPromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.freeProductId,
    required this.freeProductName,
    required this.freeProductImage,
    required this.freeProductPrice,
    required this.everyXTotal,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.freeProductEveryXTotal,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        freeProductId,
        freeProductName,
        freeProductImage,
        freeProductPrice,
        everyXTotal,
      ];

  @override
  String toString() {
    return '''FreeProductEveryXTimesPromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        freeProductId: $freeProductId,
        freeProductName: $freeProductName,
        freeProductImage: $freeProductImage,
        freeProductPrice: $freeProductPrice,
        everyXTotal: $everyXTotal,
      }''';
  }

  FreeProductEveryXTotalPromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? freeProductId,
    String? freeProductName,
    String? freeProductImage,
    String? freeProductPrice,
    int? everyXTotal,
  }) {
    return FreeProductEveryXTotalPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      freeProductId: freeProductId ?? this.freeProductId,
      freeProductName: freeProductName ?? this.freeProductName,
      freeProductImage: freeProductImage ?? this.freeProductImage,
      freeProductPrice: freeProductPrice ?? this.freeProductPrice,
      everyXTotal: everyXTotal ?? this.everyXTotal,
    );
  }

  factory FreeProductEveryXTotalPromotion.fromJson(Map<String, dynamic> json) =>
      FreeProductEveryXTotalPromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        freeProductId: json["freeProductId"],
        freeProductName: json["freeProductName"],
        freeProductImage: json["freeProductImage"],
        freeProductPrice: json["freeProductPrice"],
        everyXTotal: json["everyXTotal"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "freeProductId": freeProductId,
        "freeProductName": freeProductName,
        "freeProductImage": freeProductImage,
        "freeProductPrice": freeProductPrice,
        "everyXTotal": everyXTotal,
      };
}

class FlashSalePromotion extends Discount {
  final String salePrice;
  final DateTime endTime;

  const FlashSalePromotion({
    required int id,
    required String title,
    required String tag,
    required String titleWhenApplied,
    required this.salePrice,
    required this.endTime,
  }) : super(
          id: id,
          title: title,
          type: DiscountType.flashSale,
          tag: tag,
          titleWhenApplied: titleWhenApplied,
        );

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        tag,
        titleWhenApplied,
        salePrice,
        endTime,
      ];

  @override
  String toString() {
    return '''FlashSalePromotion {
        id: $id,
        title: $title,
        type: $type,
        tag: $tag,
        titleWhenApplied: $titleWhenApplied,
        salePrice: $salePrice,
        endTime: $endTime,
      }''';
  }

  FlashSalePromotion copyWith({
    int? id,
    String? title,
    String? tag,
    String? titleWhenApplied,
    String? salePrice,
    DateTime? endTime,
  }) {
    return FlashSalePromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      titleWhenApplied: titleWhenApplied ?? this.titleWhenApplied,
      salePrice: salePrice ?? this.salePrice,
      endTime: endTime ?? this.endTime,
    );
  }

  factory FlashSalePromotion.fromJson(Map<String, dynamic> json) =>
      FlashSalePromotion(
        id: json["id"],
        title: json["title"],
        tag: json["tag"],
        titleWhenApplied: json["titleWhenApplied"],
        salePrice: json["salePrice"],
        endTime: DateTime.parse(json["endTime"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "tag": tag,
        "titleWhenApplied": titleWhenApplied,
        "salePrice": salePrice,
        "endTime": endTime.toIso8601String(),
      };
}
