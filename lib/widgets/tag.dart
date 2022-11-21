import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.title,
    this.closable = false,
    this.onClose,
    this.closeIcon = Icons.close,
  });
  final String title;
  final bool closable;
  final VoidCallback? onClose;
  final IconData? closeIcon;
  @override
  Widget build(BuildContext context) {
    page({required Widget child}) => Styled.widget(child: child)
        .padding(vertical: 4, horizontal: 8)
        .decorated(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        );

    final tagText = Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    if (closable) {
      final closeBtn = Icon(closeIcon, size: 16, color: Colors.grey)
          .gestures(onTap: onClose)
          .padding(horizontal: 4);
      return [tagText, closeBtn]
          .toRow(mainAxisSize: MainAxisSize.min)
          .parent(page);
    }

    return tagText.parent(page);
  }
}
