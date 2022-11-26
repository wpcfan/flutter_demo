import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:styled_widget/styled_widget.dart';

class QuantityStepper extends StatefulWidget {
  const QuantityStepper({
    super.key,
    this.minusIcon = Icons.remove,
    this.plusIcon = Icons.add,
    this.iconSize = 16,
    this.iconColor = Colors.black87,
    this.iconDisabledColor = Colors.grey,
    this.iconBackgroundColor = Colors.white,
    this.iconBorderColor = Colors.grey,
    this.iconDisabledBorderColor = Colors.white70,
    this.iconBorderWidth = 1,
    this.iconBorderRadius = 4,
    this.iconPadding = 0,
    this.textFontSize = 12,
    this.textPadding = 4,
    this.minValue = 1,
    this.maxValue = 999,
    this.step = 1,
    this.onChanged,
    this.textFieldWidth = 32,
    this.maxLength = 3,
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
  final void Function(int, bool)? onChanged;
  final double textFieldWidth;
  final int maxLength;

  @override
  State<QuantityStepper> createState() => QuantityStepperState();
}

class QuantityStepperState extends State<QuantityStepper> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _quantity = 1;

  @override
  void initState() {
    _quantity = widget.minValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final minus = IconButton(
      onPressed: _quantity > widget.minValue
          ? () => setState(() {
                _quantity -= widget.step;
                _formKey.currentState?.patchValue({'quantity': '$_quantity'});
                widget.onChanged?.call(_quantity, _quantity >= widget.minValue);
              })
          : null,
      icon: Icon(
        widget.minusIcon,
      ),
      iconSize: widget.iconSize,
      color: widget.iconColor,
      disabledColor: widget.iconDisabledColor,
      padding: EdgeInsets.all(widget.iconPadding),
    )
        .decorated(
          color: widget.iconBackgroundColor,
          borderRadius: BorderRadius.circular(widget.iconBorderRadius),
          border: Border.all(
            color: widget.iconBorderColor,
            width: widget.iconBorderWidth,
          ),
        )
        .constrained(
            width: widget.iconSize +
                widget.iconPadding * 2 +
                widget.iconBorderWidth * 2,
            height: widget.iconSize +
                widget.iconPadding * 2 +
                widget.iconBorderWidth * 2);

    final textField = FormBuilder(
      key: _formKey,
      child: FormBuilderTextField(
        name: 'quantity',
        initialValue: '$_quantity',
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: TextStyle(fontSize: widget.textFontSize, color: Colors.black),
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(widget.textPadding),
            border: InputBorder.none,
            errorStyle: const TextStyle(
              height: 0,
              color: Colors.transparent,
            )),
        onChanged: (value) {
          if (value != null && value.isNotEmpty) {
            final quantity = int.parse(value);
            if (quantity == _quantity) return;
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              setState(() {
                _quantity = quantity;
                _formKey.currentState?.patchValue({'quantity': '$_quantity'});
              });
              debugPrint('form valid: ${_formKey.currentState?.value}');
              widget.onChanged?.call(quantity, true);
            } else {
              widget.onChanged?.call(quantity, false);
            }
          } else {
            setState(() {
              _quantity = widget.minValue;
              _formKey.currentState?.patchValue({'quantity': '$_quantity'});
              widget.onChanged?.call(_quantity, _quantity >= widget.minValue);
            });
          }
        },
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.min(widget.minValue),
          FormBuilderValidators.max(widget.maxValue),
        ]),
      ).constrained(width: widget.textFieldWidth),
    );

    final plus = IconButton(
      onPressed: _quantity < widget.maxValue
          ? () => setState(() {
                _quantity += widget.step;
                _formKey.currentState?.patchValue({'quantity': '$_quantity'});
                widget.onChanged?.call(_quantity, _quantity <= widget.maxValue);
              })
          : null,
      icon: Icon(widget.plusIcon),
      iconSize: widget.iconSize,
      color: widget.iconColor,
      disabledColor: widget.iconDisabledColor,
      padding: EdgeInsets.all(widget.iconPadding),
    )
        .decorated(
          color: widget.iconBackgroundColor,
          borderRadius: BorderRadius.circular(widget.iconBorderRadius),
          border: Border.all(
            color: widget.iconBorderColor,
            width: widget.iconBorderWidth,
          ),
        )
        .constrained(
            width: widget.iconSize +
                widget.iconPadding * 2 +
                widget.iconBorderWidth * 2,
            height: widget.iconSize +
                widget.iconPadding * 2 +
                widget.iconBorderWidth * 2);

    final stepper = [
      minus,
      textField,
      plus,
    ].toRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    return stepper;
  }
}
