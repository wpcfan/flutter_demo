import 'package:demo/widgets/animation/all.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchBoxWidget extends StatefulWidget {
  const SearchBoxWidget({
    super.key,
    this.bgColor = Colors.white,
    this.iconSize = 32.0,
    this.spaceBetween = 12.0,
    this.height = 50,
    this.hints,
    this.hintFontSize = 14.0,
    required this.width,
    this.hintFontFamily = 'Horizon',
    this.hintColor = Colors.grey,
    this.dividerWidth = 1,
    this.onTapHint,
    this.borderRadius,
    this.leftIconData = Icons.search,
    this.right1IconData = Icons.camera_alt,
    this.right2IconData = Icons.qr_code_scanner,
    this.iconColor = Colors.grey,
    this.onTapLeftIcon,
    this.onTapRight1Icon,
    this.onTapRight2Icon,
  });
  final Color bgColor;
  final double iconSize;
  final double spaceBetween;
  final double height;
  final double width;
  final List<String>? hints;
  final double hintFontSize;
  final String hintFontFamily;
  final Color hintColor;
  final double dividerWidth;
  final double? borderRadius;
  final IconData? leftIconData;
  final IconData? right1IconData;
  final IconData? right2IconData;
  final Color iconColor;
  final void Function(String hint)? onTapHint;
  final VoidCallback? onTapLeftIcon;
  final VoidCallback? onTapRight1Icon;
  final VoidCallback? onTapRight2Icon;

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  int _hintIndex = 0;

  double get textFieldWidth => {
        if (widget.leftIconData != null &&
            widget.right1IconData != null &&
            widget.right2IconData != null)
          widget.width -
              widget.iconSize * 3 -
              widget.spaceBetween * 6 -
              widget.dividerWidth,
        if (widget.leftIconData != null &&
            widget.right1IconData != null &&
            widget.right2IconData == null)
          widget.width - widget.iconSize * 2 - widget.spaceBetween * 4,
        if (widget.leftIconData != null &&
            widget.right1IconData == null &&
            widget.right2IconData == null)
          widget.width - widget.iconSize - widget.spaceBetween * 2,
        if (widget.leftIconData == null &&
            widget.right1IconData != null &&
            widget.right2IconData != null)
          widget.width -
              widget.iconSize * 2 -
              widget.spaceBetween * 4 -
              widget.dividerWidth,
        if (widget.leftIconData == null &&
            widget.right1IconData != null &&
            widget.right2IconData == null)
          widget.width - widget.iconSize - widget.spaceBetween * 2,
        if (widget.leftIconData == null &&
            widget.right1IconData == null &&
            widget.right2IconData != null)
          widget.width - widget.iconSize - widget.spaceBetween * 2,
        if (widget.leftIconData == null &&
            widget.right1IconData == null &&
            widget.right2IconData == null)
          widget.width - widget.spaceBetween * 2,
      }.first;

  @override
  Widget build(BuildContext context) {
    final searchIcon = widget.leftIconData == null
        ? Container()
        : Icon(
            widget.leftIconData,
            color: widget.iconColor,
          )
            .alignment(Alignment.center)
            .constrained(width: widget.iconSize, height: widget.iconSize)
            .gestures(onTap: widget.onTapLeftIcon)
            .padding(horizontal: widget.spaceBetween);
    final hintTextStyle = TextStyle(
      color: widget.hintColor,
      fontSize: widget.hintFontSize,
      fontFamily: widget.hintFontFamily,
      fontWeight: FontWeight.w500,
    );
    final rotateHint = (widget.hints == null || widget.hints!.isEmpty
            ? Container()
            : widget.hints!.length == 1
                ? Text(
                    widget.hints!.first,
                    style: hintTextStyle,
                  )
                : DefaultTextStyle(
                    style: hintTextStyle,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: widget.hints!
                          .map((el) => RotateAnimatedText(
                                el,
                                topToBottom: false,
                                rotateOut: true,
                                transitionHeight: widget.height,
                                textAlign: TextAlign.start,
                                alignment: Alignment.centerLeft,
                                duration: const Duration(seconds: 2),
                              ))
                          .toList(),
                      onNext: (index, isLast) => setState(() {
                        _hintIndex = index;
                      }),
                    ),
                  ))
        .constrained(width: textFieldWidth, height: widget.height)
        .gestures(
          onTap: widget.onTapHint == null
              ? null
              : () => widget.onTapHint!(widget.hints![_hintIndex]),
        );

    final right1Icon = widget.right1IconData == null
        ? Container()
        : Icon(
            widget.right1IconData,
            color: widget.iconColor,
          )
            .alignment(Alignment.center)
            .constrained(width: widget.iconSize, height: widget.iconSize)
            .gestures(onTap: widget.onTapRight1Icon);

    final divider =
        widget.right1IconData == null || widget.right2IconData == null
            ? Container()
            : VerticalDivider(
                color: widget.iconColor.withOpacity(0.4),
                thickness: 1.0,
                width: widget.dividerWidth,
              )
                .constrained(height: widget.iconSize * 0.8)
                .padding(horizontal: widget.spaceBetween);

    final right2Icon = widget.right2IconData == null
        ? Container()
        : Icon(
            widget.right2IconData,
            color: widget.iconColor,
          )
            .alignment(Alignment.center)
            .constrained(width: widget.iconSize, height: widget.iconSize)
            .gestures(onTap: widget.onTapRight2Icon);

    final rightGroup = [
      right1Icon,
      divider,
      right2Icon,
    ]
        .toRow(mainAxisSize: MainAxisSize.min)
        .padding(horizontal: widget.spaceBetween);

    final leftGroup = [
      searchIcon,
      rotateHint,
    ].toRow(mainAxisSize: MainAxisSize.max);

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: widget.borderRadius == null
            ? BorderRadius.circular(widget.height / 2)
            : BorderRadius.circular(widget.borderRadius!),
      ),
      child: [
        leftGroup.expanded(),
        rightGroup,
      ]
          .toRow(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
          .constrained(width: widget.width, height: widget.height),
    );
  }
}
