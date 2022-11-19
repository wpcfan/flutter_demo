import 'package:auto_route/auto_route.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    page({required Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: MediaQuery.of(context).size.height - (2 * 30))
        .safeArea()
        .scrollable();

    return <Widget>[
      const UserCard(),
      const ActionsRow(),
      const Settings(),
    ].toColumn().parent(page);
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  Widget _buildUserRow() {
    return <Widget>[
      const RoundIcon(
        icon: Icons.account_circle,
        iconSize: 30,
        backgroundColor: Colors.white,
      ).padding(right: 10),
      <Widget>[
        const Text(
          'Rein Gundersen Bentdal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 5),
        Text(
          'Creative builder',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  Widget _buildUserStats() {
    return <Widget>[
      const StatItem(title: '846', subtitle: 'Collect'),
      const StatItem(title: '1.2k', subtitle: 'Followers'),
      const StatItem(title: '267', subtitle: 'Track'),
      const StatItem(title: '39', subtitle: 'Coupons'),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(vertical: 10);
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(), _buildUserStats()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 20, vertical: 10)
        .decorated(
            color: const Color(0xff3977ff),
            borderRadius: BorderRadius.circular(20))
        .elevation(
          5,
          shadowColor: const Color(0xff3977ff),
          borderRadius: BorderRadius.circular(20),
        )
        .height(175)
        .alignment(Alignment.center);
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  Widget _buildActionItem(String name, IconData icon) {
    final Widget actionIcon = RoundIcon(icon: icon).padding(bottom: 5);

    final Widget actionText = Text(
      name,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: 12,
      ),
    );

    return <Widget>[
      actionIcon,
      actionText,
    ].toColumn().padding(vertical: 20);
  }

  @override
  Widget build(BuildContext context) => <Widget>[
        _buildActionItem('Wallet', Icons.attach_money),
        _buildActionItem('Delivery', Icons.card_giftcard),
        _buildActionItem('Message', Icons.message),
        _buildActionItem('Service', Icons.room_service),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround);
}

class SettingsItemModel {
  final Key key;
  final IconData icon;
  final Color bgColor;
  final String title;
  final String description;
  const SettingsItemModel({
    required this.key,
    required this.bgColor,
    required this.description,
    required this.icon,
    required this.title,
  });
}

List<SettingsItemModel> settingsItems(context) => [
      const SettingsItemModel(
        key: Key('address'),
        icon: Icons.location_on,
        bgColor: Color(0xff8D7AEE),
        title: 'Address',
        description: 'Ensure your harvesting address',
      ),
      const SettingsItemModel(
        key: Key('privacy'),
        icon: Icons.lock,
        bgColor: Color(0xffF468B7),
        title: 'Privacy',
        description: 'System permission change',
      ),
      const SettingsItemModel(
        key: Key('general'),
        icon: Icons.menu,
        bgColor: Color(0xffFEC85C),
        title: 'General',
        description: 'Basic functional settings',
      ),
      const SettingsItemModel(
        key: Key('notification'),
        icon: Icons.notifications,
        bgColor: Color(0xff5FD0D3),
        title: 'Notifications',
        description: 'Take over the news in time',
      ),
      const SettingsItemModel(
        key: Key('support'),
        icon: Icons.question_answer,
        bgColor: Color(0xffBFACAA),
        title: 'Support',
        description: 'We are here to help',
      ),
      SettingsItemModel(
        key: const Key('language'),
        icon: Icons.language,
        bgColor: const Color(0xffBBCCAA),
        title: AppLocalizations.of(context)!.settings_language,
        description:
            AppLocalizations.of(context)!.settings_language_description,
      ),
    ];

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) => settingsItems(context)
      .map((settingsItem) => SettingsItem(
            key: settingsItem.key,
            icon: settingsItem.icon,
            iconBgColor: settingsItem.bgColor,
            title: settingsItem.title,
            subtitle: settingsItem.description,
            onTap: () {
              if (settingsItem.key == const Key('language')) {
                context.router.pushNamed('/language');
              }
            },
          ))
      .toList()
      .toColumn();
}
