part of './settings_page.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  @override
  Widget build(BuildContext context) => <Widget>[
        const ActionItem(title: 'Wallet', icon: Icons.attach_money)
            .padding(vertical: 20),
        const ActionItem(title: 'Delivery', icon: Icons.card_giftcard)
            .padding(vertical: 20),
        const ActionItem(title: 'Message', icon: Icons.message)
            .padding(vertical: 20),
        const ActionItem(title: 'Service', icon: Icons.room_service)
            .padding(vertical: 20),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround);
}
