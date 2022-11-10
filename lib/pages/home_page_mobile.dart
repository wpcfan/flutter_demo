part of './home_page.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
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
            return AboveTabWidget(
              state: state,
              tabs: const [
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'About',
                ),
                Tab(
                  text: 'Contact',
                ),
              ],
              tabController: _tabController!,
            );
          },
        ),
      ),
    );
  }
}

class AboveTabWidget extends StatelessWidget {
  final PageBlockState state;
  final TabController tabController;
  final List<Widget> tabs;
  const AboveTabWidget(
      {Key? key,
      required this.state,
      required this.tabController,
      required this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
          itemExtent: 50,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
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
        SliverAppBar(
          pinned: true,
          floating: false,
          bottom: TabBar(
            controller: tabController,
            tabs: tabs,
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                itemBuilder: (_, index) => Container(
                  alignment: Alignment.center,
                  color: Colors.pink[100 * (index % 9)],
                  height: 50,
                  child: Text(
                    'tab 1 item $index',
                  ),
                ),
                itemCount: 10,
              ),
              ListView.builder(
                itemBuilder: (_, index) => Container(
                  alignment: Alignment.center,
                  color: Colors.green[100 * (index % 9)],
                  height: 50,
                  child: Text('tab 2 item $index',
                      style: const TextStyle(fontSize: 20)),
                ),
                itemCount: 20,
              ),
              ListView.builder(
                itemBuilder: (_, index) => Container(
                  alignment: Alignment.center,
                  color: Colors.yellow[100 * (index % 9)],
                  height: 50,
                  child: Text('tab 3 item $index',
                      style: const TextStyle(fontSize: 20)),
                ),
                itemCount: 30,
              ),
            ],
          ),
        ),
      ],
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

class TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  get tabBar {
    return TabBar(
      controller: tabController,
      tabs: tabs,
    );
  }

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;
  final TabController tabController;
  final List<Widget> tabs;

  TabHeaderDelegate({
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: TabBar(
        tabs: tabs,
        controller: tabController,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
