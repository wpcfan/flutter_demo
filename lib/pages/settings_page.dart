import 'package:auto_route/auto_route.dart';
import 'package:demo/config.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

part 'settings_page_actions_row.dart';
part 'settings_page_setting_items.dart';
part 'settings_page_user_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    page({required Widget child}) => Styled.widget(child: child)
        .padding(
            vertical: listVerticalPadding, horizontal: screenHorizontalPadding)
        .safeArea()
        .scrollable();

    return <Widget>[
      const UserCard(),
      const ActionsRow(),
      const Settings(),
    ].toColumn().parent(page);
  }
}
