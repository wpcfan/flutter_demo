import 'package:flutter/material.dart';

class TodoLoadingWidget extends StatelessWidget {
  const TodoLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: const CircularProgressIndicator(),
    );
  }
}
