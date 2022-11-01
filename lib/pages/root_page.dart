import 'package:demo/routes.dart';
import 'package:demo/states/counter_cubit.dart';
import 'package:demo/states/message_cubit.dart';
import 'package:demo/states/tab_cubit.dart';
import 'package:demo/states/theme_cubit.dart';
import 'package:demo/states/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageCubit, String?>(
      listener: ((context, state) {
        if (state != null) {
          ScaffoldMessenger.of(context)
              .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state),
          ));
        }
      }),
      child: BlocBuilder<TabCubit, int>(
        builder: (context, currentPage) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Demo Home Page'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              child: const Icon(Icons.toggle_on),
            ),
            body: BlocProvider(
              create: (context) => CounterCubit(),
              child: tabs[currentPage],
            ),
            bottomNavigationBar: buildTabBar(currentPage, context),
          );
        },
      ),
    );
  }

  BottomNavigationBar buildTabBar(int currentPage, BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index) {
        context.read<TabCubit>().changeTab(index);
        if (index == 2) {
          context.read<TodoCubit>().getTodos();
        }
      },
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
    );
  }
}
