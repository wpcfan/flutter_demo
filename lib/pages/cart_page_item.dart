part of 'cart_page.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.cartItem});
  final CartItem cartItem;

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
        ? Image.network(
            cartItem.images.first,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('error: $error');
              return Image.asset('images/100x100.png');
            },
          ).padding(vertical: 8, right: 12)
        : null;

    final productTitle = Text(
      cartItem.name,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ).padding(bottom: 8);

    final attributes = cartItem.attributes
        .map((it) => Text(
              '${it.key}: ${it.value}',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
                .padding(horizontal: 4, vertical: 2)
                .backgroundColor(Colors.grey[200]!)
                .decorated(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[300]!, width: 1)))
        .toList()
        .toRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center);

    final productDesc = cartItem.attributes.isNotEmpty
        ? attributes
        : Text(
            cartItem.description,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
            .padding(horizontal: 8, vertical: 4)
            .backgroundColor(Colors.grey[200]!)
            .padding(bottom: 8);

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
          ].toRow(mainAxisSize: MainAxisSize.max).padding(top: 8)
        : null;

    final productPrice = Text(
      cartItem.unitTotal.formatted ?? '',
      style: const TextStyle(
          fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );

    final flashSalePrice = flashSaleIndex >= 0
        ? Text(
            (discount as FlashSalePromotion).salePrice,
            style: const TextStyle(
                fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
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
        .padding(top: 12, bottom: 8);

    final rowAbovePrice = [
      productTitle,
      productDesc,
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
      cartItem.isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
      color: cartItem.isSelected ? Colors.red : Colors.grey,
    ).padding(right: 8);

    final control = [selectedIcon, right.expanded()]
        .whereType<Widget>()
        .toList()
        .toRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(horizontal: 16, vertical: 8)
        .backgroundColor(Colors.white)
        .decorated(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        )
        .padding(bottom: 8);

    return control;
  }
}
