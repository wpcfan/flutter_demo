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
    this.leftIcon = Icons.expand_more,
    this.collapseIcon = Icons.expand_less,
    this.iconColor = Colors.grey,
    this.onLeftTap,
    this.onRightTap,
  });
  final String title;
  final double titleFontSize;
  final Color titleColor;
  final IconData rightIcon;
  final Color sectionIconColor;
  final IconData leftIcon;
  final IconData collapseIcon;
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
        ));
    final leftBtn = IconButton(
        onPressed: onLeftTap,
        icon: Icon(
          leftIcon,
          color: iconColor,
        ));
    final titleRow = [titleText, leftBtn].toRow(mainAxisSize: MainAxisSize.max);
    final rightBtn = IconButton(
      icon: Icon(
        rightIcon,
        color: sectionIconColor,
      ),
      onPressed: onRightTap,
    );
    final titleBar = <Widget>[titleRow, rightBtn].toRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
    return titleBar.padding(horizontal: 12, vertical: 12);
  }
}
