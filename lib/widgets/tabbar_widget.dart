import 'package:demo/states/tab_cubit.dart';
import 'package:demo/states/todo_cubit.dart';
import 'package:demo/tab_def.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabbarWidget extends StatelessWidget {
  const TabbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(
      builder: (context, currentPage) {
        return BottomNavigationBar(
          currentIndex: currentPage,
          items: tabItems,
          onTap: (index) {
            context.read<TabCubit>().changeTab(index);
            if (index == 2) {
              context.read<TodoCubit>().getTodos();
            }
          },
        );
      },
    );
  }
}
