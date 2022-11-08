import 'package:demo/bloc/all.dart';
import 'package:demo/models/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) =>
            context.read<TodoBloc>().add(TodoToggleEvent(todo: todo)),
      ),
    );
  }
}
