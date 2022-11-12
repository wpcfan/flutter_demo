part of 'product_row.dart';

class ProductCardOneRowOneWidget extends StatelessWidget {
  const ProductCardOneRowOneWidget(
      {super.key,
      required this.product,
      required this.width,
      required this.height});
  final ProductData product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final imageHeight = height - 2 * listHorizontalPadding;
    const double spaceVertical = 4;
    page({required Widget child}) => Styled.widget(child: child)
        .padding(
            horizontal: listHorizontalPadding, vertical: listVerticalPadding)
        .constrained(maxWidth: width)
        .backgroundColor(Colors.white)
        .border(all: 1, color: Colors.grey);
    // 商品名称
    final productName = Text(
      product.name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ).padding(bottom: spaceVertical);
    // 商品描述
    final productDescription = Text(
      product.description,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
      softWrap: true,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ).padding(bottom: spaceVertical);
    // 商品原价：划线价
    final productOriginalPrice = product.originalPrice != null
        ? product.originalPrice!
            .lineThru()
            .padding(bottom: spaceVertical, right: 8)
            .alignment(Alignment.centerRight)
        : const SizedBox();
    // 商品价格
    final productPrice = product.price
        .toPriceWithDecimalSize(defaultFontSize: 16, decimalFontSize: 12)
        .padding(bottom: spaceVertical)
        .alignment(Alignment.centerRight);
    final priceRow = [productOriginalPrice, productPrice].toRow(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
    );
    // 商品名称和描述形成一列
    final nameAndDescColumn = <Widget>[
      productName,
      productDescription,
    ].toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start);
    // 商品名称和描述和价格形成一列，价格需要沉底，所以使用Expanded
    final right = [nameAndDescColumn, priceRow]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start)
        .padding(right: screenHorizontalPadding)
        .expanded();
    // 商品图片
    final productImage = Image.network(
      product.image,
      fit: BoxFit.cover,
    )
        .constrained(height: imageHeight, width: imageHeight)
        .padding(right: listHorizontalPadding);
    // 商品图片和右边的名称和描述和价格形成一行
    return [productImage, right]
        .toRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start)
        .parent(page);
  }
}
