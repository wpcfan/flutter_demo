import 'package:demo/states/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) => reducer(state),
      buildWhen: (previous, current) => current is TodoLoaded,
    );
  }

  Widget reducer(TodoState state) {
    if (state is TodoLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TodoLoaded) {
      return buildTodoList(state);
    } else if (state is TodoError) {
      return Center(child: Text(state.message));
    } else {
      return const Center(child: Text('No data'));
    }
  }

  ListView buildTodoList(TodoLoaded state) {
    return ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) {
          final todo = state.todos[index];
          return ListTile(
              title: Text(todo.title),
              trailing: Checkbox(
                value: todo.completed,
                onChanged: (value) => context.read<TodoCubit>().toggle(todo),
              ));
        });
  }
}
