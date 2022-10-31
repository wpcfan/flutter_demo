import 'package:demo/repositories/todo_repository.dart';
import 'package:demo/states/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => TodoRepository(), child: const TodoView());
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoRepo = RepositoryProvider.of<TodoRepository>(context);
    todoRepo.getTodos();
    return BlocProvider(
        create: (context) =>
            TodoCubit(repository: context.read<TodoRepository>()),
        child: const TodoList());
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
      if (state is TodoLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TodoLoaded) {
        return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description ?? ''),
                  trailing: Checkbox(
                      value: todo.completed,
                      onChanged: (value) {
                        context.read<TodoCubit>().toggle(todo);
                      }));
            });
      } else if (state is TodoError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: Text('No data'));
      }
    }, buildWhen: (previous, current) {
      if (current is TodoLoaded) {
        return true;
      } else {
        return false;
      }
    });
  }
}
