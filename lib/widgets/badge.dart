import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.title,
    this.titleFontColor = Colors.white,
    this.titleFontSize = 12,
    this.titleFontWeight = FontWeight.bold,
    this.backgroundColor = Colors.red,
    this.padding = 4,
  });
  final String title;
  final Color titleFontColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final Color backgroundColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: titleFontColor,
          fontSize: titleFontSize,
          fontWeight: titleFontWeight),
    ).padding(all: padding).backgroundColor(backgroundColor);
  }
}
