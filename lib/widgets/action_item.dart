import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'round_icon.dart';

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.icon,
    required this.title,
    this.spaceBetweenIconAndTitle = 5,
    this.titleFontSize = 12,
  });
  final IconData icon;
  final String title;
  final double spaceBetweenIconAndTitle;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    final Widget actionIcon =
        RoundIcon(icon: icon).padding(bottom: spaceBetweenIconAndTitle);

    final Widget actionText = Text(
      title,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: titleFontSize,
      ),
    );

    return <Widget>[
      actionIcon,
      actionText,
    ].toColumn();
  }
}
