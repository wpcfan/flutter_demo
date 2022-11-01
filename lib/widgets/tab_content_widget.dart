import 'package:demo/states/counter_cubit.dart';
import 'package:demo/states/tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabContentWidget extends StatelessWidget {
  final List<Widget> tabs;
  const TabContentWidget({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(
      builder: (context, state) => BlocProvider(
        create: (context) => CounterCubit(),
        child: tabs[state],
      ),
    );
  }
}
