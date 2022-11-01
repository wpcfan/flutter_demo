import 'package:demo/states/tab_cubit.dart';
import 'package:demo/states/todo_cubit.dart';
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Learn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Todo',
            ),
          ],
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
