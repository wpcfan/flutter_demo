part of 'todo_cubit.dart';

@immutable
abstract class TodoState {
  final List<Todo> todos;
  final int page;
  final int limit;

  const TodoState({this.todos = const [], this.page = 1, this.limit = 20});
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  const TodoLoaded(List<Todo> todos, int page, int limit)
      : super(todos: todos, page: page, limit: limit);
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
}
