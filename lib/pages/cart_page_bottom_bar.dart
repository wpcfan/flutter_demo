part of 'cart_page.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      [
        [
          Radio(value: true, groupValue: false, onChanged: (value) {}),
          const Text('全选'),
        ].toRow(),
        [const Text('Total: \$100'), const Text('优惠减 \$20')]
            .toColumn()
            .padding(horizontal: 8),
      ].toRow(),
      ElevatedButton(
        onPressed: () {},
        child: const Text('Checkout'),
      ),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
        .backgroundColor(Colors.white);
  }
}
