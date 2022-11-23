part of './home_page.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PageBlockBloc>();
    bloc.add(const PageBlockFetched('mobile', 'home'));
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
    final blocksPinned = blocksWithoutWaterfall
        .where((el) => el.type == PageBlockType.pinnedHeader)
        .toList();
    final blocksList = blocksWithoutWaterfall
        .where((el) => el.type != PageBlockType.pinnedHeader)
        .toList();
    final topPadding = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200.0,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      title: SearchBoxWidget(
                        width: screenWidth - 32 - 64,
                        height: 32,
                        iconSize: 24,
                        spaceBetween: 12,
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
                      ),
                      expandedTitleScale: 1.3,
                      titlePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      background: Image.network(
                        'https://picsum.photos/seed/1/600/300',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ...blocksPinned.map((el) => SliverPersistentHeader(
                        pinned: true,
                        delegate: PinnedHeaderDelegate(
                          pageBlock: el as PinnedHeaderPageBlock,
                          topPadding: topPadding,
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        final pageBlock = blocksList[index];
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
                      childCount: blocksList.length,
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
    final blocksPinned = state.pageBlocks
        .where((el) => el.type == PageBlockType.pinnedHeader)
        .toList();
    final blocksList = state.pageBlocks
        .where((el) => el.type != PageBlockType.pinnedHeader)
        .toList();
    final topPadding = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        ...blocksPinned.map((el) => SliverPersistentHeader(
              pinned: true,
              delegate: PinnedHeaderDelegate(
                pageBlock: el as PinnedHeaderPageBlock,
                topPadding: topPadding,
              ),
            )),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              final pageBlock = blocksList[index];
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
            childCount: blocksList.length,
          ),
        ),
      ],
    );
  }
}
