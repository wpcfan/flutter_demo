import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class StatItem extends StatelessWidget {
  const StatItem(
      {super.key,
      required this.title,
      this.titleFontSize = 20,
      this.titleMaxLines = 1,
      this.titleColor = Colors.white,
      required this.subtitle,
      this.subtitleMaxLines = 1,
      this.subtitleColor,
      this.subtitleFontSize = 12,
      this.space = 5});
  final String title;
  final double titleFontSize;
  final int titleMaxLines;
  final Color titleColor;
  final String subtitle;
  final double subtitleFontSize;
  final Color? subtitleColor;
  final int subtitleMaxLines;
  final double space;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ).fontSize(titleFontSize).textColor(titleColor).padding(bottom: space),
      Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      )
          .textColor(subtitleColor ?? titleColor.withOpacity(0.6))
          .fontSize(subtitleFontSize),
    ].toColumn();
  }
}
