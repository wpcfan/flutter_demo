import 'package:demo/bloc/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

part 'cart_page_bottom_bar.dart';
part 'cart_page_discount_row.dart';
part 'cart_page_item.dart';
part 'cart_page_tag_row.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// AppBar 的 action 数组中如果有 TextButton，其文本颜色会被设置为主题色
    /// 因此需要显式设置其文本颜色
    final ButtonStyle style = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary);
    context.read<CartBloc>().add(CartLoadEvent());
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
          TextButton(
            onPressed: () {},
            style: style,
            child: const Text('Edit'),
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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.loadStatus == BlocStatus.success) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: state.cart?.items.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: CartItemCard(cartItem: state.cart!.items[index]),
                      );
                    }),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CartBottomBar(
                    subTotal: state.cart!.subTotal,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
