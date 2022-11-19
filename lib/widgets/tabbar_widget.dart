import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabbarWidget extends StatelessWidget {
  final TabsRouter tabsRouter;
  const TabbarWidget({super.key, required this.tabsRouter});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.calculate),
          label: 'Counter',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Todo',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
      onTap: (index) {
        tabsRouter.setActiveIndex(index);
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
