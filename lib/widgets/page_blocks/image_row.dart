import 'package:demo/models/all.dart';
import 'package:flutter/material.dart';

class ImageRowWidget extends StatelessWidget {
  const ImageRowWidget({super.key, required this.pageBlock});
  final ImageRowPageBlock pageBlock;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = pageBlock.width! / pageBlock.height!;
    final padding = MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    final width = MediaQuery.of(context).size.width - padding;
    final height = width / aspectRatio;
    return SizedBox(
        height: height,
        child: Row(
          children: pageBlock.data.map((el) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(el.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
