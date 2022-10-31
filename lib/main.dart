import 'package:demo/routes.dart';
import 'package:demo/tab_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getRootTheme(),
        home: const RootPage(),
        routes: routes());
  }

  ThemeData getRootTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FloatingActionButton pressed');
        },
        child: const Icon(Icons.add),
      ),
      body: pages[currentPage],
      bottomNavigationBar: buildTabBar(currentPage, (int index) {
        setState(() {
          currentPage = index;
        });
      }),
    );
  }
}
