import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: ElevatedButton(
        onPressed: () async {
          final perfs = await SharedPreferences.getInstance();
          if (perfs.containsKey('sessionToken')) {
            perfs.remove('sessionToken');
          }
          context.router.navigate(const RootRoute());
        },
        child: const Text('Logout'),
      ),
    );
  }
}
