part of 'search_page.dart';

class RankItemWithImage extends StatelessWidget {
  const RankItemWithImage({
    super.key,
    required this.item,
    this.onTap,
  });
  final RankingData item;
  final void Function(Link)? onTap;

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      item.image,
      width: 100,
      height: 100,
    );
    final badge = BadgeWidget(title: item.sort.toString());

    final imageWithBadge = [
      image,
      Positioned(
        top: 0,
        left: 0,
        child: badge,
      ),
    ].toStack();

    final title = Text(
      item.title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ).alignment(Alignment.centerLeft).padding(bottom: 8).flexible();

    final subTitle = Text(
      item.subtitle,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ).alignment(Alignment.centerLeft).padding(bottom: 8).flexible();

    final content = [title, subTitle]
        .toColumn(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(horizontal: 8)
        .expanded();

    return [imageWithBadge, content]
        .toRow(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(all: 8)
        .gestures(onTap: () => onTap?.call(item.link));
  }
}
