import 'package:demo/models/todo_model.dart';
import 'package:demo/repositories/todo_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit({required this.repository})
      : super(const TodoInitial([], 1, 10, null)) {
    getTodos();
  }

  Future<List<Todo>> getTodos({int page = 1, int limit = 20}) async {
    emit(TodoLoading(state.todos, state.page, state.limit, null));
    try {
      var todos = await repository.getTodos(page, limit);
      if (page > 1) {
        todos = [...state.todos!, ...todos];
      }
      emit(TodoLoaded(todos, page, limit, null));
      return todos;
    } catch (e) {
      emit(TodoError(state.todos, state.page, state.limit, e.toString()));
      return [];
    }
  }

  Future<List<Todo>> refresh() async {
    return getTodos(page: 1, limit: state.limit!);
  }

  Future<void> toggle(Todo todo) async {
    final todos =
        (state is TodoLoaded ? (state as TodoLoaded).todos : []) as List<Todo>;
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index >= 0) {
      todos[index] = todo.copyWith(completed: !todo.completed);
      emit(TodoLoaded(todos, state.page, state.limit, null));
      await repository.updateTodoById(todo.id!, todo);
    }
  }

  Future<void> add(Todo todo) async {
    final todos =
        (state is TodoLoaded ? (state as TodoLoaded).todos : []) as List<Todo>;
    todos.add(todo);
    emit(TodoLoaded(todos, state.page, state.limit, null));
    await repository.createTodo(todo);
  }

  Future<void> delete(Todo todo) async {
    final todos =
        (state is TodoLoaded ? (state as TodoLoaded).todos : []) as List<Todo>;
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index >= 0) {
      todos.removeAt(index);
      emit(TodoLoaded(todos, state.page, state.limit, null));
      await repository.deleteTodoById(todo.id!);
    }
  }
}
