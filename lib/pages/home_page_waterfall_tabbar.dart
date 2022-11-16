part of 'home_page.dart';

class WaterfallTabbarWidget extends StatelessWidget {
  const WaterfallTabbarWidget({
    Key? key,
    required this.innerBoxIsScrolled,
    required this.data,
  }) : super(key: key);
  final bool innerBoxIsScrolled;
  final List<WaterfallData> data;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      forceElevated: innerBoxIsScrolled,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            labelPadding: const EdgeInsets.symmetric(
                horizontal: 30), // Space between tabs
            indicator: const UnderlineTabIndicator(
              borderSide:
                  BorderSide(color: Colors.white, width: 2), // Indicator height
              insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
            ),
            tabs: data.map((data) {
              return Tab(
                text: data.title,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
