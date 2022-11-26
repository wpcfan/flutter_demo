part of 'cart_page.dart';

class ProductTag {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final double borderWidth;
  final double borderRadius;

  const ProductTag({
    this.title = '',
    this.backgroundColor = Colors.white,
    this.textColor = Colors.green,
    this.borderColor = Colors.green,
    this.fontSize = 10,
    this.borderWidth = 1,
    this.borderRadius = 2,
  });
}

class CartTagRow extends StatelessWidget {
  const CartTagRow({super.key, required this.tags});
  final List<ProductTag> tags;
  @override
  Widget build(BuildContext context) {
    final tagWidgets = tags
        .map((tag) {
          return Text(
            tag.title,
            style: TextStyle(
                fontSize: tag.fontSize,
                color: tag.textColor,
                fontWeight: FontWeight.bold),
          )
              .alignment(Alignment.center)
              .backgroundColor(tag.backgroundColor)
              .padding(all: 2)
              .decorated(
                  border: Border.all(
                      color: tag.borderColor, width: tag.borderWidth),
                  borderRadius: BorderRadius.circular(tag.borderRadius))
              .padding(right: 8);
        })
        .toList()
        .toRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center);
    return tagWidgets;
  }
}
