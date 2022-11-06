import 'package:demo/models/todo_model.dart';
import 'package:demo/repositories/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit({required this.repository}) : super(TodoInitial()) {
    getTodos();
  }

  Future<List<Todo>> getTodos() async {
    emit(TodoLoading());
    try {
      final todos = await repository.getTodos();
      emit(TodoLoaded(todos));
      return todos;
    } catch (e) {
      emit(TodoError(e.toString()));
      return [];
    }
  }

  Future<void> toggle(Todo todo) async {
    final todos =
        (state is TodoLoaded ? (state as TodoLoaded).todos : []) as List<Todo>;
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index >= 0) {
      todos[index] = todo.copyWith(completed: !todo.completed);
      emit(TodoLoaded(todos));
      await repository.updateTodoById(todo.id!, todo);
    }
  }

  Future<void> add(Todo todo) async {
    final todos =
        (state is TodoLoaded ? (state as TodoLoaded).todos : []) as List<Todo>;
    todos.add(todo);
    emit(TodoLoaded(todos));
    await repository.createTodo(todo);
  }

  Future<void> delete(Todo todo) async {
    final todos =
        (state is TodoLoaded ? (state as TodoLoaded).todos : []) as List<Todo>;
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index >= 0) {
      todos.removeAt(index);
      emit(TodoLoaded(todos));
      await repository.deleteTodoById(todo.id!);
    }
  }
}
