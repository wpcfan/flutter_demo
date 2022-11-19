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
          label: AppLocalizations.of(context)!.tab_home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calculate),
          label: AppLocalizations.of(context)!.tab_counter,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: AppLocalizations.of(context)!.tab_todo,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppLocalizations.of(context)!.tab_my,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.tab_settings,
        ),
      ],
      onTap: (index) {
        tabsRouter.setActiveIndex(index);
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
