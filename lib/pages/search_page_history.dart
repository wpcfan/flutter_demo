part of './search_page.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({
    super.key,
    this.isExpanded = false,
    this.onToggleExpand,
    this.onClearHistory,
    this.expandedLines = 30,
    this.collapseLines = 2,
    this.tags = const [],
    this.horizontalSpacing = 12,
    this.verticalSpacing = 8,
    required this.title,
  });
  final bool isExpanded;
  final VoidCallback? onToggleExpand;
  final VoidCallback? onClearHistory;
  final int expandedLines;
  final int collapseLines;
  final List<Widget> tags;
  final double horizontalSpacing;
  final double verticalSpacing;
  final String title;

  @override
  Widget build(BuildContext context) {
    final searchHistoryTitle = SearchSectionTitle(
      title: title,
      leftIcon: isExpanded ? Icons.expand_less : Icons.expand_more,
      onLeftTap: onToggleExpand,
      onRightTap: onClearHistory,
    );
    final tagFlexWrap = ExtendedWrap(
      maxLines: isExpanded ? expandedLines : collapseLines,
      minLines: collapseLines,
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: horizontalSpacing,
      runSpacing: verticalSpacing,
      children: tags,
    );
    return [searchHistoryTitle, tagFlexWrap]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .padding(horizontal: 12);
  }
}
