import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.title,
    required this.tagColor,
    this.closable = false,
    this.onClose,
    this.closeIcon = Icons.close,
    this.iconSize = 16,
    this.iconColor = Colors.grey,
    this.fontSize = 12,
    this.fontColor = Colors.grey,
    this.tagHorizontalPadding = 8,
    this.tagVerticalPadding = 4,
    this.maxWidth,
    required this.borderRadius,
  });
  final String title;
  final bool closable;
  final VoidCallback? onClose;
  final IconData? closeIcon;
  final double iconSize;
  final Color iconColor;
  final double fontSize;
  final Color fontColor;
  final Color tagColor;
  final double tagHorizontalPadding;
  final double tagVerticalPadding;
  final BorderRadius borderRadius;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    page({required Widget child}) => Styled.widget(child: child)
        .padding(vertical: tagVerticalPadding, horizontal: tagHorizontalPadding)
        .decorated(
          color: tagColor,
          borderRadius: borderRadius,
        );

    final tagText = Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    if (closable) {
      final closeBtn = Icon(closeIcon, size: iconSize, color: iconColor)
          .gestures(onTap: onClose)
          .flexible();
      return [tagText, closeBtn]
          .toRow(mainAxisSize: MainAxisSize.min)
          .parent(page);
    }

    return tagText.parent(page);
  }
}
