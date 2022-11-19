import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    this.iconColor = Colors.white,
    this.iconSize = 20,
    this.iconPaddingSize = 50,
    required this.title,
    this.titleFontSize = 16,
    this.titleFontWeight = FontWeight.bold,
    required this.subtitle,
    this.height = 80,
    this.onTap,
    this.subtitleFontSize = 12,
    this.subtitleFontWeight = FontWeight.bold,
    this.subtitleColor = Colors.black26,
    this.spaceBetweenTitleAndSubtitle = 5,
    this.iconLeftMargin = 15,
    this.iconRightMargin = 10,
    this.borderRadius = 15,
    this.shadowColor = const Color(0x30000000),
    this.backgroundColor = Colors.white,
  });
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final double iconPaddingSize;
  final Color iconBgColor;
  final String title;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final String subtitle;
  final double subtitleFontSize;
  final FontWeight subtitleFontWeight;
  final Color subtitleColor;
  final double height;
  final double spaceBetweenTitleAndSubtitle;
  final double iconLeftMargin;
  final double iconRightMargin;
  final double borderRadius;
  final Color shadowColor;
  final Color backgroundColor;
  final void Function()? onTap;
  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    settingsItem({required Widget child}) => Styled.widget(child: child)
        .alignment(Alignment.center)
        .borderRadius(all: widget.borderRadius)
        .ripple()
        .backgroundColor(widget.backgroundColor, animate: true)
        .clipRRect(all: widget.borderRadius) // clip ripple
        .borderRadius(all: widget.borderRadius, animate: true)
        .elevation(
          pressed ? 0 : 20,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          shadowColor: widget.shadowColor,
        ) // shadow borderRadius
        .constrained(height: widget.height)
        .padding(vertical: 12) // margin
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTapDown: (details) => debugPrint('tapDown'),
          onTap: widget.onTap,
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(const Duration(milliseconds: 150), Curves.easeOut);

    final Widget icon = RoundIcon(
            icon: widget.icon,
            color: widget.iconColor,
            iconSize: widget.iconSize,
            size: widget.iconPaddingSize,
            backgroundColor: widget.iconBgColor)
        .padding(left: widget.iconLeftMargin, right: widget.iconRightMargin);

    final Widget title = Text(
      widget.title,
      style: TextStyle(
        fontWeight: widget.titleFontWeight,
        fontSize: widget.titleFontSize,
      ),
    ).padding(bottom: widget.spaceBetweenTitleAndSubtitle);

    final Widget subtitle = Text(
      widget.subtitle,
      style: TextStyle(
        color: widget.subtitleColor,
        fontWeight: widget.subtitleFontWeight,
        fontSize: widget.subtitleFontSize,
      ),
    );

    return settingsItem(
      child: <Widget>[
        icon,
        <Widget>[
          title,
          subtitle,
        ].toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ].toRow(),
    );
  }
}
