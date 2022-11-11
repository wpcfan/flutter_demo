part of './home_page.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  final tabs = const [
    Tab(
      icon: Icon(Icons.home),
      text: 'Home',
    ),
    Tab(
      icon: Icon(Icons.calculate),
      text: 'Counter',
    ),
    Tab(
      icon: Icon(Icons.list),
      text: 'Todo',
    ),
  ];
  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Center(
        child: BlocBuilder<PageBlockBloc, PageBlockState>(
          builder: (_, state) {
            if (state.status == PageBlockStatus.initial) {
              return const CircularProgressIndicator();
            }
            if (state.status == PageBlockStatus.failure) {
              return Text(state.error ?? 'Something went wrong');
            }
            return HomeWidget(
                tabs: tabs, tabController: tabController!, state: state);
          },
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final List<Tab> tabs;
  final TabController tabController;
  final PageBlockState state;
  const HomeWidget(
      {super.key,
      required this.tabs,
      required this.tabController,
      required this.state});

  @override
  Widget build(BuildContext context) {
    // statusBar height
    // final double statusBarHeight = MediaQuery.of(context).padding.top;
    const double pinnedHeaderHeight = kToolbarHeight;
    return ExtendedNestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: HomePageHeaderDelegate(maxExtent: 350, minExtent: 0),
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
                  }
                },
                childCount: state.pageBlocks.length,
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return const ProductCardOneRowOne();
                },
                childCount: 10,
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  alignment: Alignment.center,
                  color: Colors.purple[100 * (index % 9)],
                  child: Text('grid item $index'),
                ),
                childCount: 10,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
            ),
          ];
        },
        //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
        pinnedHeaderSliverHeightBuilder: () {
          return pinnedHeaderHeight;
        },
        //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
        onlyOneScrollInBody: true,
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: tabs,
              isScrollable: false,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (context) => CustomScrollView(
                        key: const PageStorageKey<String>('Tab1'),
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(8),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48,
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => ListTile(
                                  title: Text('Item $index'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (context) => CustomScrollView(
                        key: const PageStorageKey<String>('Tab2'),
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(8),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48,
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => ListTile(
                                  title: Text('Item $index'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (context) => CustomScrollView(
                        key: const PageStorageKey<String>('Tab3'),
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(8),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48,
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => ListTile(
                                  title: Text('Item $index'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
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

class ProductCardOneRowOne extends StatelessWidget {
  const ProductCardOneRowOne({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingOfScreen = MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    page({required Widget child}) => Styled.widget(child: child)
        .padding(vertical: 8, horizontal: 12)
        .constrained(
            maxWidth: MediaQuery.of(context).size.width - paddingOfScreen)
        .backgroundColor(Colors.white)
        .border(all: 1, color: Colors.grey);
    final productName = const Text(
      'Product Name',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
    ).textAlignment(TextAlign.start).padding(bottom: 4).expanded();
    final productDescription = const Text(
      'Product Description',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    ).padding(bottom: 4).expanded();
    final productPrice = const Text(
      'Product Price',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.red,
      ),
    ).padding(bottom: 4).expanded().alignment(Alignment.centerRight);
    final rightRow = <Widget>[
      productName,
      productDescription,
      productPrice,
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start)
        .padding(left: 12)
        .expanded();
    final productImage = Image.network(
      'https://picsum.photos/600/300/?image=12',
      fit: BoxFit.cover,
    ).constrained(height: 100, width: 100);
    return [productImage, rightRow]
        .toRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start)
        .parent(page);
  }
}
