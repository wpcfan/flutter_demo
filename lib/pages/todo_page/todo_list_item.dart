import 'package:demo/bloc/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/widgets/loading_scroll_list/loading_silver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListItem extends LoadingSilverItem<Todo> {
  const TodoListItem({super.key, required Todo item}) : super(item: item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      trailing: Checkbox(
        value: item.completed,
        onChanged: (value) =>
            context.read<TodoBloc>().add(TodoToggleEvent(todo: item)),
      ),
    );
  }
}
