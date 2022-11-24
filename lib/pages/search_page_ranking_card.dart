part of 'search_page.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
    required this.item,
    required this.width,
    this.itemsWithImage = 3,
    this.onTapMoreLink,
    this.onTapItem,
  });
  final RankingListData item;
  final double width;
  final int itemsWithImage;
  final VoidCallback? onTapMoreLink;
  final void Function(Link)? onTapItem;

  @override
  Widget build(BuildContext context) {
    final titleRow = RankingHeader(
      item: item,
      width: width,
      onTapMoreLink: onTapMoreLink,
    );

    final list = item.data
        .map((e) => e.sort < itemsWithImage + 1
            ? RankItemWithImage(
                item: e,
                onTap: onTapItem,
              )
            : RankItem(
                item: e,
                onTap: onTapItem,
              ))
        .toList();

    return [
      titleRow,
      ...list,
    ].toColumn().card().constrained(width: width);
  }
}
