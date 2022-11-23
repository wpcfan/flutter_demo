import 'package:demo/models/all.dart';
import 'package:flutter/material.dart';

class BlocWrapperWidget extends StatelessWidget {
  const BlocWrapperWidget({
    super.key,
    required this.child,
    required this.status,
    this.error,
    required this.loadingWidget,
    required this.errorWidget,
  });
  final Widget child;
  final Widget loadingWidget;
  final Widget errorWidget;
  final BlocStatus status;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return status == BlocStatus.initial
        ? loadingWidget
        : status == BlocStatus.failure
            ? errorWidget
            : child;
  }
}
