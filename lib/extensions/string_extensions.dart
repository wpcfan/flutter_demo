import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String get first => substring(0, 1);

  String get last => substring(length - 1, length);

  EasyRichText toEasyRichText({
    TextStyle? defaultStyle,
    List<EasyRichTextPattern>? patternList,
  }) =>
      EasyRichText(
        this,
        defaultStyle: defaultStyle,
        patternList: patternList,
      );

  EasyRichText toPriceWithDecimalSize(
      {double defaultFontSize = 14,
      double decimalFontSize = 12.0,
      String decimalSign = '.'}) {
    final defaultStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: defaultFontSize,
      color: Colors.red,
    );
    final parts = split(decimalSign);
    if (parts.length != 2) {
      return toEasyRichText(defaultStyle: defaultStyle, patternList: const []);
    }
    final first = parts.first;
    final last = parts.last;
    return toEasyRichText(
      defaultStyle: defaultStyle,
      patternList: [
        EasyRichTextPattern(
          targetString: '\\$first',
          matchWordBoundaries: false,
          style: TextStyle(
            fontSize: defaultFontSize,
          ),
        ),
        EasyRichTextPattern(
          targetString: last,
          matchWordBoundaries: false,
          style: TextStyle(
            fontSize: decimalFontSize,
          ),
        ),
      ],
    );
  }

  Text lineThru({double fontSize = 12.0}) {
    return Text(this,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: Colors.grey,
          decoration: TextDecoration.lineThrough,
        ));
  }

  double widthOfText(
      {double fontSize = 12.0, FontWeight fontWeight = FontWeight.w600}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: this,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}
