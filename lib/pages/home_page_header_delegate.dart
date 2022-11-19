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
    final screenWidth = MediaQuery.of(context).size.width;
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
            left: 16,
            bottom: 32,
            child: SearchBoxWidget(
              width: screenWidth - 32.0,
              hints: const [
                'Search for a movie',
                'Search for a TV show',
                'Search for a person',
              ],
            )),
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

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget(
      {super.key,
      this.bgColor = Colors.white,
      this.iconSize = 32.0,
      this.spaceBetween = 12.0,
      this.height = 50,
      this.hints,
      this.hintFontSize = 14.0,
      required this.width,
      this.hintFontFamily = 'Horizon'});
  final Color bgColor;
  final double iconSize;
  final double spaceBetween;
  final double height;
  final double width;
  final List<String>? hints;
  final double hintFontSize;
  final String hintFontFamily;
  @override
  Widget build(BuildContext context) {
    final searchIcon = const Icon(
      Icons.search,
      color: Colors.grey,
    )
        .alignment(Alignment.center)
        .constrained(width: iconSize, height: iconSize)
        .padding(horizontal: spaceBetween);
    final hintTextStyle = TextStyle(
      color: Colors.grey,
      fontSize: hintFontSize,
      fontFamily: hintFontFamily,
      fontWeight: FontWeight.w500,
    );
    final rotateHint = hints == null || hints!.isEmpty
        ? Container()
        : hints!.length == 1
            ? Text(
                hints!.first,
                style: hintTextStyle,
              )
            : DefaultTextStyle(
                style: hintTextStyle,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: hints!
                      .map((el) => RotateAnimatedText(el, topToBottom: false))
                      .toList(),
                  onTap: () {
                    debugPrint("Tap Event");
                  },
                ),
              );

    final cameraIcon = const Icon(
      Icons.camera_alt,
      color: Colors.grey,
    )
        .alignment(Alignment.center)
        .constrained(width: iconSize, height: iconSize);

    final divider = VerticalDivider(
      color: Colors.grey.withOpacity(0.4),
      thickness: 1.0,
      width: 1.0,
    ).constrained(height: iconSize * 0.8).padding(horizontal: spaceBetween);

    final scanIcon = const Icon(
      Icons.qr_code_scanner,
      color: Colors.grey,
    )
        .alignment(Alignment.center)
        .constrained(width: iconSize, height: iconSize);

    final rightGroup = [
      cameraIcon,
      divider,
      scanIcon,
    ].toRow(mainAxisSize: MainAxisSize.min).padding(horizontal: spaceBetween);

    final leftGroup = [
      searchIcon,
      rotateHint,
    ].toRow(mainAxisSize: MainAxisSize.min);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: [
        leftGroup,
        rightGroup,
      ]
          .toRow(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
          .constrained(width: width),
    );
  }
}
