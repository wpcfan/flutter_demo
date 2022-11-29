import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_widget/styled_widget.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    this.minusIcon = Icons.remove,
    this.plusIcon = Icons.add,
    this.iconSize = 16,
    this.iconColor = Colors.blue,
    this.iconDisabledColor = Colors.grey,
    this.iconBackgroundColor = Colors.transparent,
    this.iconBorderColor = Colors.transparent,
    this.iconDisabledBorderColor = Colors.transparent,
    this.iconBorderWidth = 0,
    this.iconBorderRadius = 0,
    this.iconPadding = 0,
    this.textFontSize = 12,
    this.textPadding = 4,
    this.minValue = 1,
    this.maxValue = 999,
    this.step = 1,
    this.onChanged,
    this.textFieldWidth = 32,
    this.maxLength = 3,
    required this.value,
  });
  final IconData minusIcon;
  final IconData plusIcon;
  final double iconSize;
  final Color iconColor;
  final Color iconDisabledColor;
  final Color iconBackgroundColor;
  final Color iconBorderColor;
  final Color iconDisabledBorderColor;
  final double iconBorderWidth;
  final double iconBorderRadius;
  final double iconPadding;
  final double textFontSize;
  final double textPadding;
  final int minValue;
  final int maxValue;
  final int step;
  final void Function(String?)? onChanged;
  final double textFieldWidth;
  final int maxLength;
  final int value;

  @override
  Widget build(BuildContext context) {
    final minus = IconButton(
      onPressed: value > minValue
          ? () => onChanged?.call((value - step).toString())
          : null,
      icon: Icon(
        minusIcon,
      ),
      iconSize: iconSize,
      color: iconColor,
      disabledColor: iconDisabledColor,
      padding: EdgeInsets.all(iconPadding),
    )
        .decorated(
          color: iconBackgroundColor,
          borderRadius: BorderRadius.circular(iconBorderRadius),
          border: Border.all(
            color: iconBorderColor,
            width: iconBorderWidth,
          ),
        )
        .constrained(
            width: iconSize + iconPadding * 2 + iconBorderWidth * 2,
            height: iconSize + iconPadding * 2 + iconBorderWidth * 2);

    final textField = TextFormField(
      initialValue: value.toString(),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontSize: textFontSize, color: Colors.black),
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(textPadding),
          border: InputBorder.none,
          errorStyle: const TextStyle(
            height: 0,
            color: Colors.transparent,
          )),
      onChanged: (value) {
        onChanged?.call(value);
      },
    ).constrained(width: textFieldWidth);

    final plus = IconButton(
      onPressed: value < maxValue
          ? () => onChanged?.call((value + step).toString())
          : null,
      icon: Icon(plusIcon),
      iconSize: iconSize,
      color: iconColor,
      disabledColor: iconDisabledColor,
      padding: EdgeInsets.all(iconPadding),
    )
        .decorated(
          color: iconBackgroundColor,
          borderRadius: BorderRadius.circular(iconBorderRadius),
          border: Border.all(
            color: iconBorderColor,
            width: iconBorderWidth,
          ),
        )
        .constrained(
            width: iconSize + iconPadding * 2 + iconBorderWidth * 2,
            height: iconSize + iconPadding * 2 + iconBorderWidth * 2);

    final stepper = [
      minus,
      textField,
      plus,
    ].toRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    return Material(
      child: stepper,
    );
  }
}
