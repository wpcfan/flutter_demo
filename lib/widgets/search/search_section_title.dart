import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchSectionTitle extends StatelessWidget {
  const SearchSectionTitle({
    super.key,
    required this.title,
    this.titleFontSize = 16,
    this.titleColor = Colors.black54,
    this.rightIcon = Icons.delete_forever_outlined,
    this.sectionIconColor = Colors.grey,
    this.leftIcon,
    this.iconColor = Colors.grey,
    this.onLeftTap,
    this.onRightTap,
  });
  final String title;
  final double titleFontSize;
  final Color titleColor;
  final IconData? rightIcon;
  final Color sectionIconColor;
  final IconData? leftIcon;
  final Color iconColor;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  @override
  Widget build(BuildContext context) {
    final titleText = Text(title,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
          color: titleColor,
        )).alignment(Alignment.centerLeft);
    if (leftIcon == null && rightIcon == null) {
      return titleText;
    }
    final leftIconWidget = leftIcon == null
        ? null
        : Icon(leftIcon, color: iconColor).gestures(onTap: onLeftTap);
    final rightIconWidget = rightIcon == null
        ? null
        : Icon(rightIcon, color: sectionIconColor).gestures(onTap: onRightTap);
    final left = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleText,
        leftIconWidget,
      ].whereType<Widget>().toList(),
    );
    if (rightIcon == null) {
      return left;
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        left,
        rightIconWidget,
      ].whereType<Widget>().toList(),
    );
  }
}
