import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ElevatedButton(
          onPressed: () => context.router.pushNamed('/learn-flutter-page'),
          child: const Text('ElevatedButton'),
        ),
      ),
    );
  }
}
