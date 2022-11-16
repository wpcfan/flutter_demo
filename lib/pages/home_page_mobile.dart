part of './home_page.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

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
        return HomeWidget(state: state);
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  final PageBlockState state;
  const HomeWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    try {
      final waterfallBlock = state.pageBlocks
              .firstWhere((el) => el.type == PageBlockType.waterfall)
          as WaterfallPageBlock;
      final blocksWithoutWaterfall = state.pageBlocks
          .where((el) => el.type != PageBlockType.waterfall)
          .toList();
      return WaterfallLayout(
          waterfallBlock: waterfallBlock,
          blocksWithoutWaterfall: blocksWithoutWaterfall);
    } catch (e) {
      return NoWaterfallLayout(state: state);
    }
  }
}

class WaterfallLayout extends StatelessWidget {
  const WaterfallLayout({
    Key? key,
    required this.waterfallBlock,
    required this.blocksWithoutWaterfall,
  }) : super(key: key);

  final WaterfallPageBlock waterfallBlock;
  final List<PageBlock> blocksWithoutWaterfall;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: waterfallBlock.data.length,
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: MultiSliver(
                pushPinnedChildren: false,
                children: [
                  SliverPersistentHeader(
                    floating: innerBoxIsScrolled,
                    delegate:
                        HomePageHeaderDelegate(maxExtent: 350, minExtent: 0),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        final pageBlock = blocksWithoutWaterfall[index];
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
                          default:
                            return Container();
                        }
                      },
                      childCount: blocksWithoutWaterfall.length,
                    ),
                  ),
                  WaterfallTabbarWidget(
                    innerBoxIsScrolled: innerBoxIsScrolled,
                    data: waterfallBlock.data,
                  ),
                ],
              ),
            ),
          ];
        },
        body: SafeArea(
          child: TabBarView(
            children: waterfallBlock.data.map((data) {
              return Builder(builder: (context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(data.title),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    WaterfallMasonryWidget(data: data)
                  ],
                );
              });
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class NoWaterfallLayout extends StatelessWidget {
  const NoWaterfallLayout({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PageBlockState state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HomePageHeaderDelegate(
            minExtent: 56.0,
            maxExtent: 200.0,
          ),
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
                default:
                  return null;
              }
            },
            childCount: state.pageBlocks.length,
          ),
        ),
      ],
    );
  }
}
