part of 'search_page.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
    required this.item,
    required this.width,
    this.titleFontSize = 14,
    this.titleFontColor = Colors.red,
    this.titleFontWeight = FontWeight.bold,
    this.moreLinkText = '更多',
    this.moreLinkFontSize = 12,
    this.moreLinkColor = Colors.red,
    this.moreLinkIcon = Icons.arrow_forward_ios,
    this.moreLinkIconSize = 12,
    this.moreLinkIconColor = Colors.red,
    this.padding = 12,
    this.itemsWithImage = 3,
    this.onTapMoreLink,
  });
  final RankingListData item;
  final double width;
  final double titleFontSize;
  final Color titleFontColor;
  final FontWeight titleFontWeight;
  final String moreLinkText;
  final double moreLinkFontSize;
  final Color moreLinkColor;
  final IconData moreLinkIcon;
  final double moreLinkIconSize;
  final Color moreLinkIconColor;
  final double padding;
  final int itemsWithImage;
  final VoidCallback? onTapMoreLink;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      item.title,
      style: TextStyle(
        fontSize: titleFontSize,
        fontWeight: titleFontWeight,
        color: titleFontColor,
      ),
      textAlign: TextAlign.start,
    ).alignment(Alignment.centerLeft);

    final moreLink = Text(
      moreLinkText,
      style: TextStyle(
        fontSize: moreLinkFontSize,
        color: moreLinkColor,
      ),
    ).alignment(Alignment.centerRight);

    final moreIcon = Icon(
      moreLinkIcon,
      size: moreLinkIconSize,
      color: moreLinkIconColor,
    ).alignment(Alignment.centerRight);

    final more =
        [moreLink, moreIcon].toRow().ripple().gestures(onTap: onTapMoreLink);

    final titleRow = [
      title,
      more,
    ]
        .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .padding(all: padding);

    final list = item.data
        .map((e) => e.sort < itemsWithImage + 1
            ? RankItemWithImage(item: e)
            : RankItem(item: e))
        .toList();

    return [
      titleRow,
      ...list,
    ].toColumn().card().constrained(width: width);
  }
}
