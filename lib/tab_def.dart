import 'package:demo/pages/all.dart';
import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> tabItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.calculate),
    label: 'Counter',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.list),
    label: 'Todo',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'My',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Setting',
  ),
];

final List<Widget> tabs = [
  const HomePage(),
  const CounterPage(),
  const TodoPage(),
];
