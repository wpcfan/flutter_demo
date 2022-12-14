part of 'home_page.dart';

class PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => pageBlock.minHeight.toDouble() + topPadding;
  @override
  double get maxExtent => pageBlock.maxHeight.toDouble();
  final PinnedHeaderPageBlock pageBlock;
  final double topPadding;
  PinnedHeaderDelegate({
    required this.pageBlock,
    required this.topPadding,
  })  : assert(pageBlock.minHeight <= pageBlock.maxHeight),
        assert(pageBlock.minHeight >= 0),
        assert(pageBlock.data.isNotEmpty);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          pageBlock.data.first.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('error: $error');
            return Image.asset('images/100x100.png');
          },
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
            left: 16,
            bottom: 16,
            child: SearchBoxWidget(
              right2IconData: null,
              width: screenWidth - 32.0,
              hints: const [
                'Search for a movie',
                'Search for a TV show',
                'Search for a person',
              ],
              onTapHint: (hint) {
                context.router.push(
                  Search(
                    query: hint,
                  ),
                );
              },
            )),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
