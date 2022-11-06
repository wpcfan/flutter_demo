import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45
                ],
              ),
            ),
            child: const Text(
              'Foreground Text',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          Container(
            alignment: FractionalOffset.center,
            child: ElevatedButton(
              onPressed: () async {
                final perfs = await SharedPreferences.getInstance();
                if (perfs.containsKey('sessionToken')) {
                  perfs.remove('sessionToken');
                }
                context.router.push(const RootRoute());
              },
              child: const Text('Logout'),
            ),
          ),
          Container(
            alignment: FractionalOffset.topLeft,
            child: IconButton(
              icon: const Icon(Icons.access_alarm),
              onPressed: () {
                context.router.navigate(const Splash());
              },
            ),
          )
        ],
      ),
    );
  }
}
