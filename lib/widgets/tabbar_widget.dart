import 'package:auto_route/auto_route.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

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
          icon: [
            const Icon(Icons.shopping_cart),
            const BadgeWidget(
              title: '1',
              size: 12,
              titleFontSize: 8,
              borderRadius: 6,
            ).positioned(top: 0, right: 0)
          ].toStack(),
          label: AppLocalizations.of(context)!.tab_cart,
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
