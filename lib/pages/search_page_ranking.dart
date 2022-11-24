part of 'search_page.dart';

class RankingWidget extends StatelessWidget {
  const RankingWidget({
    super.key,
    required this.pageBlock,
  });
  final RankingPageBlock pageBlock;
  @override
  Widget build(BuildContext context) {
    const title = SearchSectionTitle(
      title: '分类排行',
      leftIcon: null,
      rightIcon: null,
    );
    final items = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: pageBlock.data
          .map((item) => RankingCard(
                item: item,
                width: pageBlock.width!.toDouble(),
                onTapMoreLink: () {
                  debugPrint('onTapMoreLink');
                },
              ))
          .toList()
          .toRow(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch)
          .constrained(height: 500),
    );
    return [title, items].toColumn();
  }
}
