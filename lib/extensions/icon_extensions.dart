import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

extension IconExtension on Icon {
  Widget rounded({
    required double size,
    Color? color,
    double? radius,
    double? borderWidth,
    Color? borderColor,
  }) {
    return Styled.widget(
      child: this,
    )
        .constrained(width: size, height: size)
        .alignment(Alignment.center)
        .ripple()
        .decorated(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
        )
        .clipRRect(all: size / 2);
  }
}
