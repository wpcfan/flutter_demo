part of 'cart_page.dart';

class CartItemDescription extends StatelessWidget {
  const CartItemDescription({
    super.key,
    required this.description,
    this.fontSize = 10.0,
    this.fontColor = Colors.black54,
    this.backgroundColor = Colors.black12,
  });
  final String description;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
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
        );
  }
}
