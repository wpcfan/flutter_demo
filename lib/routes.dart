import 'package:demo/profile_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'learn_flutter_page.dart';
import 'stream_page.dart';

Map<String, WidgetBuilder> routes() {
  return {
    '/home': (context) => const HomePage(),
    '/learn_flutter': (context) => const LearnFlutterPage(),
    '/stream': (context) => const StreamPage(),
    '/profile': (context) => const ProfilePage(),
  };
}

final List<Widget> pages = [
  const HomePage(),
  const ProfilePage(),
  const StreamPage()
];
