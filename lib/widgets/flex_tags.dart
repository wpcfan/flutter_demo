import 'package:demo/extensions/all.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';

class FlexTagLine {
  int lines;
  int indexOfCollapsedLine;
  FlexTagLine({required this.lines, required this.indexOfCollapsedLine});

  @override
  String toString() {
    return 'FlexTagLine{lines: $lines, indexOfCollapsedLine: $indexOfCollapsedLine}';
  }
}

class FlexTags extends StatelessWidget {
  const FlexTags({
    super.key,
    required this.tags,
    required this.width,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 4,
    this.tagHorizontalPadding = 4,
    this.tagVerticalPadding = 2,
    this.isCollapsed = false,
    this.collapsedLines = 2,
    this.collapseIcon = Icons.expand_more,
    this.expandIcon = Icons.expand_less,
    this.iconColor = Colors.grey,
    this.iconSize = 16,
    this.tagColor = Colors.grey,
    this.textColor = Colors.black54,
    this.textFontSize = 12,
    this.onToggle,
    this.onTap,
    this.displayToggleIcon = true,
  });
  final List<String> tags;
  final double horizontalSpacing;
  final double verticalSpacing;
  final double tagHorizontalPadding;
  final double tagVerticalPadding;
  final bool isCollapsed;
  final int collapsedLines;
  final IconData? expandIcon;
  final IconData? collapseIcon;
  final Color iconColor;
  final double iconSize;
  final Color tagColor;
  final Color textColor;
  final double textFontSize;
  final double width;
  final VoidCallback? onToggle;
  final void Function(String)? onTap;
  final bool displayToggleIcon;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    final tagLines = calcLines(
        tags, width, horizontalSpacing, tagHorizontalPadding, textFontSize);
    List<String> tagsToDisplay = tags;
    if (isCollapsed && tagLines.lines > collapsedLines) {
      tagsToDisplay = tags.sublist(
        0,
        tagLines.indexOfCollapsedLine < tags.length - 1
            ? tagLines.indexOfCollapsedLine + 1
            : tagLines.indexOfCollapsedLine,
      );
    }
    final tagWidgets = tagsToDisplay
        .map((tag) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap?.call(tag),
              child: TagWidget(
                title: tag,
                tagColor: tagColor,
                fontSize: textFontSize,
                fontColor: textColor,
                borderRadius: BorderRadius.circular(12),
                closable: false,
                tagHorizontalPadding: tagHorizontalPadding,
                tagVerticalPadding: tagVerticalPadding,
              ),
            ))
        .toList();
    final toggleIcon = isCollapsed && tagLines.lines > collapsedLines
        ? GestureDetector(
            onTap: onToggle,
            child: Icon(
              collapseIcon,
              color: iconColor,
              size: iconSize,
            ),
          )
        : GestureDetector(
            onTap: onToggle,
            child: Icon(
              expandIcon,
              color: iconColor,
              size: iconSize,
            ),
          );
    return Wrap(
      spacing: horizontalSpacing,
      runSpacing: verticalSpacing,
      children: displayToggleIcon ? [...tagWidgets, toggleIcon] : tagWidgets,
    );
  }

  FlexTagLine calcLines(
    List<String> tags,
    double width,
    double horizontalSpacing,
    double tagHorizontalPadding,
    double textFontSize,
  ) {
    var lines = 1;
    var lineWidth = 0.0;
    var indexOfCollapsedLine = 0;
    for (var i = 0; i < tags.length; i++) {
      final tag = tags[i];
      final tagWidth = tag.widthOfText(fontSize: textFontSize);
      final tagWidthWithPadding = tagWidth + tagHorizontalPadding * 2;
      final tagTotalWidth = tagWidthWithPadding + horizontalSpacing;

      if (lineWidth + tagTotalWidth > width) {
        // 如果当前行剩余宽度不足以放下当前tag，则换行
        lines++;
        // 如果长度大于等于容器宽度，则以容器宽度为准
        lineWidth = tagTotalWidth >= width ? width : tagTotalWidth;
      } else if (displayToggleIcon &&
          (i == tags.length - 1 || lines == collapsedLines) &&
          lineWidth + tagTotalWidth + iconSize > width) {
        // 如果启用了显示图标且当前行剩余宽度不足以放下当前tag和展开图标，则换行
        lines++;
        lineWidth = tagTotalWidth;
      } else {
        // 如果当前行剩余宽度足以放下当前tag，则不换行
        lineWidth += tagTotalWidth;
      }
      if (lines == collapsedLines) {
        indexOfCollapsedLine = i;
      }
    }
    return FlexTagLine(
      lines: lines,
      indexOfCollapsedLine: indexOfCollapsedLine,
    );
  }
}
