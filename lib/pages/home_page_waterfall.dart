part of './home_page.dart';

class WaterfallGridWidget extends StatelessWidget {
  final WaterfallData data;
  const WaterfallGridWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth =
        (screenWidth - screenHorizontalPadding * 2 - 10 - 10) / 2;
    final itemHeight = itemWidth * 4 / 3;
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 11 / 15,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = data.data[index];
          return ProductCardOneRowTwoWidget(
            product: product,
            width: itemWidth,
            height: itemHeight,
            onTap: () => debugPrint('onTap'),
            addToCart: () => debugPrint('addToCart'),
          );
        },
        childCount: data.data.length,
      ),
    );
  }
}

class WaterfallMasonryWidget extends StatelessWidget {
  const WaterfallMasonryWidget({super.key, required this.data});
  final WaterfallData data;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth =
        (screenWidth - screenHorizontalPadding * 2 - 8) / 2;
    return SliverMasonryGrid.extent(
      maxCrossAxisExtent: 300,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childCount: data.data.length,
      itemBuilder: (context, index) {
        return ProductCardOneRowTwoWidget(
          product: data.data[index],
          width: itemWidth,
          height: 400,
        );
      },
    );
  }
}
