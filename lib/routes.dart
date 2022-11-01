import 'package:demo/pages/all.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomePage(),
  '/learn_flutter': (context) => const LearnFlutterPage(),
  '/stream': (context) => const StreamPage(),
  '/todo': (context) => const TodoPage(),
};

final List<Widget> tabs = [
  const HomePage(),
  const StreamPage(),
  const TodoPage(),
];
