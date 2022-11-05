import 'package:demo/config.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            alignment: FractionalOffset.center,
            width: 150,
            height: 150,
            child: Image.network('$placeholderUri/150'),
          ),
          Container(
            color: Colors.grey,
            width: 60,
            height: 20,
            alignment: FractionalOffset.topRight,
            child: const Text(
              '3',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
