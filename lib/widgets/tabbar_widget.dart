import 'package:auto_route/auto_route.dart';
import 'package:demo/tab_def.dart';
import 'package:flutter/material.dart';

class TabbarWidget extends StatelessWidget {
  final TabsRouter tabsRouter;
  const TabbarWidget({super.key, required this.tabsRouter});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      items: tabItems,
      onTap: (index) {
        tabsRouter.setActiveIndex(index);
      },
    );
  }
}
