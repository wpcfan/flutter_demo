part of 'search_page.dart';

class RankItem extends StatelessWidget {
  const RankItem({
    super.key,
    required this.item,
    this.spacing = 8,
    this.padding = 8,
    this.onTap,
  });
  final RankingData item;
  final double spacing;
  final double padding;
  final void Function(Link)? onTap;

  @override
  Widget build(BuildContext context) {
    final badge = BadgeWidget(
      title: item.sort.toString(),
      backgroundColor: Colors.grey,
      borderRadius: 15,
    );
    final title = Text(
      item.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ).padding(left: spacing).expanded();
    return [
      badge,
      title,
    ]
        .toRow()
        .padding(all: padding)
        .gestures(onTap: () => onTap?.call(item.link));
  }
}
