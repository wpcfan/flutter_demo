import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class RoundIcon extends StatefulWidget {
  const RoundIcon({
    super.key,
    this.color = const Color(0xFF42526F),
    this.backgroundColor = const Color(0xfff6f5f8),
    required this.icon,
    this.shadowColor = const Color(0x30000000),
    this.size = 50,
    this.iconSize = 20,
  });
  final Color color;
  final Color backgroundColor;
  final Color shadowColor;
  final IconData icon;
  final double iconSize;
  final double size;

  @override
  State<RoundIcon> createState() => _RoundIconState();
}

class _RoundIconState extends State<RoundIcon> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Icon(widget.icon, size: widget.iconSize, color: widget.color)
        .alignment(Alignment.center)
        .ripple()
        .constrained(width: widget.size, height: widget.size)
        .backgroundColor(widget.backgroundColor)
        .elevation(
          pressed ? 0 : widget.size,
          borderRadius: BorderRadius.circular(widget.size / 2),
          shadowColor: widget.shadowColor,
        )
        .clipOval()
        .gestures(
            onTapChange: (tapState) => setState(() => pressed = tapState));
  }
}
