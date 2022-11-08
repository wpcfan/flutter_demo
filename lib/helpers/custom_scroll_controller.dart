import 'package:flutter/material.dart';

class CustomScrollController extends ScrollController {
  final Function() onScrollEnd;
  final Function() onScrollTop;
  final double scrollEndThreshold;
  final double scrollEndOffset;
  final double scrollTopOffset;

  CustomScrollController(
      {this.scrollEndThreshold = 1.0,
      this.scrollEndOffset = 0.0,
      this.scrollTopOffset = 0.0,
      required this.onScrollTop,
      required this.onScrollEnd});

  @override
  void notifyListeners() {
    super.notifyListeners();
    var maxScroll = position.maxScrollExtent * scrollEndThreshold;
    if (position.pixels >= maxScroll + scrollEndOffset) {
      onScrollEnd();
    }
    if (position.pixels <= -scrollTopOffset) {
      onScrollTop();
    }
  }
}
