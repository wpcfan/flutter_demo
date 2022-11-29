part of 'cart_page.dart';

class CartItemAttributeRow extends StatelessWidget {
  const CartItemAttributeRow({
    super.key,
    required this.attributes,
    this.fontSize = 10.0,
    this.fontColor = Colors.black54,
    this.backgroundColor = Colors.black12,
  });
  final List<KeyValueAttribute> attributes;
  final Color fontColor;
  final double fontSize;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return attributes
        .map(
          (it) => Text(
            '${it.key}: ${it.value}',
            style: TextStyle(fontSize: fontSize, color: fontColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
              .padding(horizontal: 4, vertical: 2)
              .backgroundColor(backgroundColor)
              .decorated(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
        )
        .toList()
        .toRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center);
  }
}
