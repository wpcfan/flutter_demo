part of 'cart_page.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.cartItem,
    this.horizontalSpacing = 8.0,
    this.verticalSpacing = 8.0,
    this.horizontalPadding = 12.0,
    this.verticalPadding = 8.0,
    this.borderRadius = 8.0,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.imageSize = 100.0,
    this.maxTitleLines = 2,
    this.titleFontSize = 14.0,
    this.titleFontColor = Colors.black87,
    this.priceFontSize = 14.0,
    this.priceFontColor = Colors.red,
    this.priceFontWeight = FontWeight.bold,
    this.flashSaleFontSize = 12.0,
    this.flashSaleFontWeight = FontWeight.bold,
    this.flashSaleFontColor = Colors.red,
    this.checkedIcon = Icons.check_circle_rounded,
    this.uncheckedIcon = Icons.circle_outlined,
    this.checkedIconColor = Colors.red,
    this.uncheckedIconColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.descriptionFontSize = 10.0,
    this.descriptionFontColor = Colors.black54,
    this.descriptionBackgroundColor = Colors.black12,
    this.onToggleSelection,
    this.imageBorderRadius = 8.0,
  });
  final CartItem cartItem;
  final double horizontalSpacing;
  final double verticalSpacing;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double imageSize;
  final int maxTitleLines;
  final double titleFontSize;
  final Color titleFontColor;
  final double priceFontSize;
  final Color priceFontColor;
  final FontWeight priceFontWeight;
  final double flashSaleFontSize;
  final Color flashSaleFontColor;
  final FontWeight flashSaleFontWeight;
  final IconData checkedIcon;
  final IconData uncheckedIcon;
  final Color checkedIconColor;
  final Color uncheckedIconColor;
  final Color backgroundColor;
  final double descriptionFontSize;
  final Color descriptionFontColor;
  final Color descriptionBackgroundColor;
  final VoidCallback? onToggleSelection;
  final double imageBorderRadius;

  @override
  Widget build(BuildContext context) {
    final discounts = ((cartItem.metadata?['discounts'] ?? []) as List<dynamic>)
        .map((it) => Discount.fromJson(it as Map<String, dynamic>))
        .toList();
    final discount = discounts.isNotEmpty
        ? discounts.firstWhere(
            (el) => el.isApplied,
            orElse: () => discounts.first,
          )
        : null;
    final discountRow =
        discount != null ? CartDiscountRow(discount: discount) : null;

    final image = cartItem.images.isNotEmpty
        ? ImageWidget(
                image: cartItem.images.first,
                width: imageSize,
                height: imageSize,
                radius: imageBorderRadius)
            .padding(vertical: verticalSpacing, right: horizontalSpacing)
        : null;

    final productTitle = Text(
      cartItem.name,
      style: TextStyle(fontSize: titleFontSize, color: titleFontColor),
      overflow: TextOverflow.ellipsis,
      maxLines: maxTitleLines,
    ).padding(vertical: verticalSpacing);

    final productDesc = cartItem.attributes.isNotEmpty
        ? CartItemAttributeRow(
            attributes: cartItem.attributes,
            fontSize: descriptionFontSize,
            fontColor: descriptionFontColor,
            backgroundColor: descriptionBackgroundColor,
          )
        : CartItemDescription(
            description: cartItem.description,
            fontSize: descriptionFontSize,
            fontColor: descriptionFontColor,
            backgroundColor: descriptionBackgroundColor,
          );

    final tags = ((cartItem.metadata?['tags'] ?? []) as List<dynamic>)
        .map((it) => ProductTag.fromJson(it as Map<String, dynamic>))
        .toList();
    final tagRow = tags.isNotEmpty ? CartTagRow(tags: tags) : null;

    final flashSaleIndex =
        discounts.indexWhere((el) => el.type == DiscountType.flashSale);
    final flashSaleCountDwon = flashSaleIndex >= 0
        ? [
            FlashSaleCountDown(
              endTime:
                  (discounts[flashSaleIndex] as FlashSalePromotion).endTime,
              gridentStartColor: Colors.red[100],
              gridentEndColor: Colors.white,
              prefix: AppLocalizations.of(context)!.flash_prefix,
            ).expanded()
          ]
            .toRow(mainAxisSize: MainAxisSize.max)
            .padding(bottom: verticalSpacing)
        : null;

    final productPrice = Text(
      cartItem.unitTotal.formatted ?? '',
      style: TextStyle(
        fontSize: priceFontSize,
        color: priceFontColor,
        fontWeight: priceFontWeight,
      ),
    );

    final flashSalePrice = flashSaleIndex >= 0
        ? Text(
            (discount as FlashSalePromotion).salePrice,
            style: TextStyle(
              fontSize: flashSaleFontSize,
              color: flashSaleFontColor,
              fontWeight: flashSaleFontWeight,
            ),
          )
        : null;

    final priceCol = [
      productPrice,
      flashSalePrice,
    ]
        .whereType<Widget>()
        .toList()
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start);

    final stepperKey = GlobalKey<QuantityStepperState>();
    final stepper = QuantityStepper(
      key: stepperKey,
      onChanged: (quantity, isValid) {
        debugPrint('quantity: $quantity, isValid: $isValid');
      },
    );

    final priceRow = [
      priceCol,
      stepper,
    ]
        .whereType<Widget>()
        .toList()
        .toRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(bottom: verticalSpacing);

    final rowAbovePrice = [
      productTitle,
      productDesc.padding(bottom: verticalSpacing),
      tagRow,
      flashSaleCountDwon,
    ].whereType<Widget>().toList().toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        );

    final rightCol = [rowAbovePrice, priceRow]
        .whereType<Widget>()
        .toList()
        .toColumn(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        )
        .expanded();

    // 要撑起来，需要使用 IntrinsicHeight 包裹，里面的内容同时包裹 expanded
    final secondRow = IntrinsicHeight(
      child: [
        image,
        rightCol,
      ].whereType<Widget>().toList().toRow(),
    );

    final right = [
      discountRow,
      secondRow,
    ].whereType<Widget>().toList().toColumn(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start);

    final selectedIcon = Icon(
      cartItem.isSelected ? checkedIcon : uncheckedIcon,
      color: cartItem.isSelected ? checkedIconColor : uncheckedIconColor,
    )
        .ripple(
          customBorder: const CircleBorder(),
        )
        .padding(right: horizontalSpacing)
        .gestures(onTap: onToggleSelection);

    final control = [selectedIcon, right.expanded()]
        .whereType<Widget>()
        .toList()
        .toRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        )
        .backgroundColor(backgroundColor)
        .decorated(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: borderWidth),
        )
        .padding(bottom: verticalPadding);

    return control;
  }
}
