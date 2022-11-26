part of 'cart_page.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    const discountRow = CartDiscountRow(
      discount: DiscountPromotion(
          id: 1,
          title: '买就减30',
          tag: '直减',
          titleWhenApplied: '已减30',
          discount: '30'),
    );

    final image = Image.network(
      'https://picsum.photos/200/200',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('error: $error');
        return Image.asset('images/100x100.png');
      },
    ).padding(vertical: 8, right: 12);

    final productTitle = const Text(
      'Item 3',
      style: TextStyle(fontSize: 14, color: Colors.black87),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ).padding(bottom: 8);

    final productDesc = const Text(
      'Item 4',
      style: TextStyle(fontSize: 10, color: Colors.grey),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    )
        .padding(horizontal: 8, vertical: 4)
        .backgroundColor(Colors.grey[200]!)
        .padding(bottom: 8);

    const tagRow = CartTagRow(
      tags: [
        ProductTag(
          title: 'Tag 1',
        ),
        ProductTag(
          title: 'Tag 2',
        ),
        ProductTag(
          title: 'Tag 3',
        ),
        ProductTag(
          title: 'Tag 4',
        ),
      ],
    );
    final endTime = DateTime.now().add(const Duration(days: 1));
    final flashSaleCountDwon = [
      FlashSaleCountDown(
        endTime: endTime,
        gridentStartColor: Colors.red[100],
        gridentEndColor: Colors.white,
        prefix: AppLocalizations.of(context)!.flash_prefix,
      ).expanded()
    ].toRow(mainAxisSize: MainAxisSize.max).padding(top: 8);
    const productPrice = Text(
      'Item 9',
      style: TextStyle(
          fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );

    const discountPrice = Text(
      'Item 10',
      style: TextStyle(
          fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );

    final priceCol = [
      productPrice,
      discountPrice,
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);

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
        .toRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(top: 12, bottom: 8);

    final rightCol = [
      productTitle,
      productDesc,
      tagRow,
      flashSaleCountDwon,
      priceRow,
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )
        .expanded();

    final secondRow = [
      image,
      rightCol,
    ].toRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max);

    return [
      discountRow,
      secondRow,
    ].toColumn(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch);
  }
}
