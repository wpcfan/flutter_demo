import 'package:demo/models/all.dart';
import 'package:demo/states/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListWidget extends StatelessWidget {
  final List<Todo> todos;
  const TodoListWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
              title: Text(todo.title),
              trailing: Checkbox(
                value: todo.completed,
                onChanged: (value) => context.read<TodoCubit>().toggle(todo),
              ));
        });
  }
}
