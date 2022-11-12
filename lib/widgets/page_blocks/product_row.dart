import 'package:demo/config.dart';
import 'package:demo/extensions/string_extensions.dart';
import 'package:demo/models/all.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

part 'product_card_one_row_one.dart';
part 'product_card_one_row_two.dart';

class ProductRowWidget extends StatelessWidget {
  const ProductRowWidget({super.key, required this.pageBlock});
  final ProductRowPageBlock pageBlock;

  @override
  Widget build(BuildContext context) {
    if (pageBlock.data.isEmpty) {
      return const SizedBox();
    }
    final aspectRatio = pageBlock.width! / pageBlock.height!;
    final width =
        MediaQuery.of(context).size.width - screenHorizontalPadding * 2;
    final height = width / aspectRatio;
    if (pageBlock.data.length == 1) {
      return SizedBox(
          height: height,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: screenHorizontalPadding,
                  vertical: spaceBetweenListItems / 2),
              child: ProductCardOneRowOneWidget(
                product: pageBlock.data.first,
                width: width,
                height: height,
              )));
    }
    return IntrinsicHeight(
      child: pageBlock.data
          .take(2)
          .map((el) => ProductCardOneRowTwoWidget(
                product: el,
                width: (width - spaceBetweenListItems) / 2,
                height: height - spaceBetweenListItems,
              ))
          .toList()
          .toRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start)
          .padding(
              horizontal: screenHorizontalPadding,
              vertical: spaceBetweenListItems / 2),
    );
  }
}
