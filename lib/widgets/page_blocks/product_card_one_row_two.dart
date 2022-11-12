part of 'product_row.dart';

class ProductCardOneRowTwoWidget extends StatelessWidget {
  const ProductCardOneRowTwoWidget(
      {super.key,
      required this.product,
      required this.width,
      required this.height});
  final ProductData product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
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
        fontSize: 14,
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
        fontSize: 12,
        color: Colors.black54,
      ),
      softWrap: true,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ).padding(bottom: spaceVertical);
    // 商品原价：划线价
    final productOriginalPrice = product.originalPrice != null
        ? product.originalPrice!.lineThru().padding(bottom: spaceVertical)
        : const SizedBox();
    // 商品价格
    final productPrice = product.price
        .toPriceWithDecimalSize(defaultFontSize: 14, decimalFontSize: 10);
    // 商品图片
    final productImage = Image.network(
      product.image,
      fit: BoxFit.fill,
    )
        .padding(
          bottom: spaceVertical,
        )
        .constrained(
            height: width - listVerticalPadding * 2,
            width: width - listHorizontalPadding * 2);
    // 商品图片、名称和描述形成一列
    final imageNameAndDesc = <Widget>[
      productImage,
      productName,
      productDescription,
    ].toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start);
    final priceRow = [productOriginalPrice, productPrice].toColumn(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
    final nameDescAndPrice = [imageNameAndDesc, priceRow].toColumn(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start);

    return nameDescAndPrice.parent(page);
  }
}
