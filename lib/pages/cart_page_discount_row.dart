part of 'cart_page.dart';

class CartDiscountRow extends StatelessWidget {
  const CartDiscountRow(
      {super.key, required this.discount, this.applied = false});
  final Discount discount;
  final bool applied;

  @override
  Widget build(BuildContext context) {
    final discountTag = Text(
      discount.tag,
      style: const TextStyle(fontSize: 10, color: Colors.white),
    ).padding(horizontal: 4).backgroundColor(Colors.red);

    final discountTitle = Text(
            applied ? discount.titleWhenApplied : discount.title,
            style: const TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold))
        .padding(left: 8);

    final discountRow = [discountTag, discountTitle].toRow(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center);
    return discountRow;
  }
}
