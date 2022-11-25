import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:styled_widget/styled_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(
          'Cart',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ).alignment(Alignment.centerLeft).padding(left: 12),
        title: [
          const Icon(Icons.location_on_outlined),
          const Text('Location'),
        ].toRow(),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  child: Text('Delete'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              leading: Radio(
                value: index,
                groupValue: 0,
                onChanged: (value) {},
              ),
              title: const CartItemCard(),
            );
          }),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CartBottomBar(),
          ),
        ],
      ),
    );
  }
}

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

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    const discountRow = CartDiscountRow();

    final image = Image.network(
      'https://picsum.photos/200/200',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
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

    const tagRow = CartTagRow();
    final endTime = DateTime.now().add(const Duration(days: 1));
    final flashSaleCountDwon = [FlashSaleCountDown(endTime: endTime).expanded()]
        .toRow(mainAxisSize: MainAxisSize.max)
        .padding(top: 8);
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

    const stepper = CartQuantityStepper();

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

class CartDiscountRow extends StatelessWidget {
  const CartDiscountRow({super.key});

  @override
  Widget build(BuildContext context) {
    final discountTag = const Text(
      '满减',
      style: TextStyle(fontSize: 10, color: Colors.white),
    ).padding(horizontal: 4).backgroundColor(Colors.red);

    final discountTitle = const Text('Item 2',
            style: TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold))
        .padding(left: 8);

    final discountRow = [discountTag, discountTitle].toRow(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center);
    return discountRow;
  }
}

class CartTagRow extends StatelessWidget {
  const CartTagRow({super.key});

  @override
  Widget build(BuildContext context) {
    final metaTag1 = const Text(
      'Item 5',
      style: TextStyle(fontSize: 10, color: Colors.white),
    )
        .alignment(Alignment.center)
        .padding(all: 2)
        .backgroundColor(Colors.green)
        .padding(right: 8);

    final metaTag2 = const Text(
      'Item 6',
      style: TextStyle(fontSize: 10, color: Colors.green),
    )
        .alignment(Alignment.center)
        .backgroundColor(Colors.white)
        .padding(all: 2)
        .decorated(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(2))
        .padding(right: 8);

    final metaTag3 = const Text(
      'Item 7',
      style: TextStyle(fontSize: 10, color: Colors.green),
    )
        .alignment(Alignment.center)
        .backgroundColor(Colors.white)
        .padding(all: 2)
        .decorated(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(2))
        .padding(right: 8);

    final metaTag4 = const Text(
      'Item 8',
      style: TextStyle(fontSize: 10, color: Colors.red),
    )
        .alignment(Alignment.center)
        .backgroundColor(Colors.white)
        .padding(all: 2)
        .decorated(
            border: Border.all(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(2))
        .padding(right: 8);

    final tagRow = [
      metaTag1,
      metaTag2,
      metaTag3,
      metaTag4,
    ].toRow(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center);
    return tagRow;
  }
}

class CartQuantityStepper extends StatelessWidget {
  const CartQuantityStepper({super.key});

  @override
  Widget build(BuildContext context) {
    const minus = Icon(Icons.remove, size: 12);
    final textField = TextFormField(
      initialValue: '1',
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(fontSize: 12, color: Colors.black),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 38),
        border: InputBorder.none,
      ),
    ).constrained(width: 20);
    const plus = Icon(Icons.add, size: 12);
    final stepper = [
      minus,
      textField,
      plus,
    ].toRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
    return stepper;
  }
}

class FlashSaleCountDown extends StatelessWidget {
  const FlashSaleCountDown({super.key, required this.endTime});
  final DateTime endTime;
  @override
  Widget build(BuildContext context) {
    final countDown = CountdownTimer(
      endTime: endTime.millisecondsSinceEpoch,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return const Text('00:00:00');
        }
        return Text(
          '秒杀 距离结束还剩'
          '${time.days != null ? '${time.days}天' : ''}'
          '${time.hours != null ? '${time.hours}时' : ''}'
          '${time.min != null ? '${time.min}分' : ''}'
          '${time.sec}秒',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.red,
          ),
        );
      },
    );
    return countDown.padding(horizontal: 8, vertical: 4).decorated(
        border: Border.all(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.red[100]!,
          ],
        ));
  }
}
