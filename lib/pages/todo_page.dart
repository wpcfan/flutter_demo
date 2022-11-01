import 'package:demo/states/todo_cubit.dart';
import 'package:demo/widgets/no_data_widget.dart';
import 'package:demo/widgets/todo_list_widget.dart';
import 'package:demo/widgets/todo_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoCubit>().getTodos();
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) => reducer(state),
      buildWhen: (previous, current) => current is TodoLoaded,
    );
  }

  Widget reducer(TodoState state) {
    if (state is TodoLoading) {
      return const TodoLoadingWidget();
    } else if (state is TodoLoaded) {
      return TodoListWidget(todos: state.todos);
    } else if (state is TodoError) {
      return Center(child: Text(state.message));
    } else {
      return const NoDataWidget();
    }
  }
}
