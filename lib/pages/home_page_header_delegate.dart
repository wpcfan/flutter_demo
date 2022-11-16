part of 'home_page.dart';

class HomePageHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;
  HomePageHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
  }) : assert(minExtent <= maxExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://picsum.photos/600/300/?image=12',
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
