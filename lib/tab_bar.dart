import 'package:flutter/material.dart';

Widget buildTabBar(int currentIndex, void Function(int) onTap) {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Learn',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'Stream',
      ),
    ],
    currentIndex: currentIndex,
    selectedItemColor: Colors.amber[800],
    onTap: onTap,
  );
}
