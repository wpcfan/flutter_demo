part of './settings_page.dart';

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
