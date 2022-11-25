part of './settings_page.dart';

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
      const SettingsItemModel(
        key: Key('theme'),
        icon: Icons.color_lens_outlined,
        bgColor: Color(0xff5FD0D3),
        title: 'Theme',
        description: 'Toggle theme',
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
              if (settingsItem.key == const Key('theme')) {
                context.read<ThemeCubit>().toggleTheme();
              }
            },
          ))
      .toList()
      .toColumn();
}
