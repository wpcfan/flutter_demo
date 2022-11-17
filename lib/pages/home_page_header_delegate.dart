part of 'home_page.dart';

class PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => pageBlock.minHeight.toDouble();
  @override
  double get maxExtent => pageBlock.maxHeight.toDouble();
  final PinnedHeaderPageBlock pageBlock;
  PinnedHeaderDelegate({
    required this.pageBlock,
  })  : assert(pageBlock.minHeight <= pageBlock.maxHeight),
        assert(pageBlock.minHeight >= 0),
        assert(pageBlock.data.isNotEmpty);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          pageBlock.data.first.image,
          fit: BoxFit.cover,
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
          left: 16.0 + shrinkOffset * 1.2,
          bottom: 16.0 + shrinkOffset * 1.05,
          child: Text(
            'Lorem ipsum',
            style: TextStyle(
              fontSize: 32.0 + shrinkOffset * 1.2,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
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
