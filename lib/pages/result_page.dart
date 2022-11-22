import 'package:auto_route/auto_route.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, @pathParam required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth - 32;
    return Scaffold(
      appBar: AppBar(
        elevation: double.minPositive,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        title: SearchBoxWidget(
          width: width,
          height: 32,
          tag: query,
          right2IconData: null,
          onTagClose: () => context.router.replace(Search(query: query)),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.grid_view_outlined)),
        ],
      ),
      body: Container(),
    );
  }
}
