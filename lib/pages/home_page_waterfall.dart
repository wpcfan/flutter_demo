part of './home_page.dart';

class WaterfallGridWidget extends StatelessWidget {
  final WaterfallData data;
  const WaterfallGridWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double spacing = 10.0;
    final double itemWidth =
        (screenWidth - screenHorizontalPadding * 2 - spacing * 2) / 2;
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: 11 / 15,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = data.data[index];
          return ProductCardOneRowTwoWidget(
            data: product,
            width: itemWidth,
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
    const double spacing = 8;
    final double itemWidth =
        (screenWidth - screenHorizontalPadding * 2 - spacing) / 2;
    return SliverMasonryGrid.extent(
      maxCrossAxisExtent: screenWidth / 2,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      childCount: data.data.length,
      itemBuilder: (context, index) {
        return ProductCardOneRowTwoWidget(
          data: data.data[index],
          width: itemWidth,
        );
      },
    );
  }
}
