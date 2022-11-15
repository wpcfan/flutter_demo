part of './home_page.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with TickerProviderStateMixin {
  double offsetY = 0.0;
  double dragDelta = 0.0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBlockBloc, PageBlockState>(
      builder: (_, state) {
        if (state.status == PageBlockStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == PageBlockStatus.failure) {
          return Center(child: Text(state.error ?? 'Something went wrong'));
        }
        return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                debugPrint('ScrollStartNotification: ');
              }
              if (notification is ScrollUpdateNotification) {
                debugPrint('''
                  ScrollUpdateNotification: ${notification.scrollDelta}\n 
                  depth: ${notification.depth}
                  ''');
              }
              return true;
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: ((notification) {
                return false;
              }),
              child: HomeWidget(state: state),
            ));
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  final PageBlockState state;
  const HomeWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (contextOuter, innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: HomePageHeaderDelegate(maxExtent: 350, minExtent: 100),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final pageBlock = state.pageBlocks[index];
                  switch (pageBlock.type) {
                    case PageBlockType.slider:
                      return ImageSliderWidget(
                        pageBlock: pageBlock as SliderPageBlock,
                      );
                    case PageBlockType.imageRow:
                      return ImageRowWidget(
                        pageBlock: pageBlock as ImageRowPageBlock,
                      );
                    case PageBlockType.productRow:
                      return ProductRowWidget(
                        pageBlock: pageBlock as ProductRowPageBlock,
                      );
                  }
                },
                childCount: state.pageBlocks.length,
              ),
            ),
            SliverOverlapAbsorber(
              handle:
                  NestedScrollView.sliverOverlapAbsorberHandleFor(contextOuter),
              sliver: SliverAppBar(
                title: const Text('NestedScrollView'),
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                bottom: const TabBar(
                  tabs: <Widget>[
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Builder(builder: (context) {
              return CustomScrollView(
                key: const PageStorageKey<String>('Tab2'),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverFixedExtentList(
                      itemExtent: 32,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ListTile(
                          title: Text('Item $index'),
                          tileColor:
                              Colors.accents[index % Colors.accents.length],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Builder(builder: (context) {
              return CustomScrollView(
                key: const PageStorageKey<String>('Tab1'),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverFixedExtentList(
                      itemExtent: 48,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ListTile(
                          title: Text('Item $index'),
                          tileColor:
                              Colors.primaries[index % Colors.primaries.length],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

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
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Lorem ipsum',
            style: TextStyle(
              fontSize: 32.0,
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
