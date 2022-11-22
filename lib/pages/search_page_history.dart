part of './search_page.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({
    super.key,
    this.isExpanded = false,
    this.onToggleExpand,
    this.onClearHistory,
    this.onTapTag,
    this.expandedLines = 30,
    this.collapseLines = 2,
    this.tags = const [],
    this.horizontalSpacing = 12,
    this.verticalSpacing = 8,
    this.textColor = Colors.grey,
    required this.tagColor,
    required this.title,
  });
  final bool isExpanded;
  final VoidCallback? onToggleExpand;
  final VoidCallback? onClearHistory;
  final void Function(String)? onTapTag;
  final int expandedLines;
  final int collapseLines;
  final List<String> tags;
  final double horizontalSpacing;
  final double verticalSpacing;
  final String title;
  final Color tagColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth - 24;
    final searchHistoryTitle = SearchSectionTitle(
      title: title,
      leftIcon: isExpanded ? Icons.expand_less : Icons.expand_more,
      onLeftTap: onToggleExpand,
      onRightTap: onClearHistory,
    );

    final tagFlexWrap = FlexTags(
      tags: tags,
      width: width,
      tagColor: tagColor,
      textColor: textColor,
      tagHorizontalPadding: 8,
      tagVerticalPadding: 4,
      isCollapsed: !isExpanded,
      displayToggleIcon: true,
      onToggle: onToggleExpand,
      onTap: onTapTag,
    );
    return [searchHistoryTitle, tagFlexWrap]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }
}
