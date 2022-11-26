import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:styled_widget/styled_widget.dart';

class FlashSaleCountDown extends StatelessWidget {
  const FlashSaleCountDown(
      {super.key,
      required this.endTime,
      this.gridentStartColor,
      this.gridentEndColor,
      this.backgroundColor,
      this.fontColor = Colors.red,
      this.borderRadius = 12,
      this.fontSize = 10,
      this.horizontalPadding = 8,
      this.verticalPadding = 4,
      this.borderColor = Colors.transparent,
      this.borderWidth = 1,
      this.prefix,
      this.strDay,
      this.strHour,
      this.strMin,
      this.strSec});
  final DateTime endTime;
  final Color? gridentStartColor;
  final Color? gridentEndColor;
  final Color? backgroundColor;
  final Color fontColor;
  final double borderRadius;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Color borderColor;
  final double borderWidth;
  final String? prefix;
  final String? strDay;
  final String? strHour;
  final String? strMin;
  final String? strSec;

  @override
  Widget build(BuildContext context) {
    final countDown = CountdownTimer(
      endTime: endTime.millisecondsSinceEpoch,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return const Text('00:00:00');
        }
        return Text(
          '${prefix ?? ''}'
          '${time.days != null ? '${time.days}${strDay ?? ':'}' : ''}'
          '${time.hours != null ? '${time.hours}${strHour ?? ':'}' : ''}'
          '${time.min != null ? '${time.min}${strMin ?? ':'}' : ''}'
          '${time.sec}${strSec ?? ''}',
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor,
          ),
        );
      },
    );
    return countDown
        .padding(horizontal: horizontalPadding, vertical: verticalPadding)
        .decorated(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor != null ? backgroundColor! : null,
            gradient: gridentStartColor != null && gridentEndColor != null
                ? LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      gridentEndColor!,
                      gridentStartColor!,
                    ],
                  )
                : null);
  }
}
