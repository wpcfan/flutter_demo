import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? error;
  const ErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error ?? ""),
            TextButton(
              onPressed: () {
                context.router.navigate(const RootRoute());
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
