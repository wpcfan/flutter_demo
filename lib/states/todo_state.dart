part of 'todo_cubit.dart';

@immutable
abstract class TodoState {
  final List<Todo>? todos;
  final int? page;
  final int? limit;
  final String? message;

  const TodoState(this.todos, this.page, this.limit, this.message);
}

class TodoInitial extends TodoState {
  const TodoInitial(super.todos, super.page, super.limit, super.message);
}

class TodoLoading extends TodoState {
  const TodoLoading(super.todos, super.page, super.limit, super.message);
}

class TodoLoaded extends TodoState {
  const TodoLoaded(super.todos, super.page, super.limit, super.message);
}

class TodoError extends TodoState {
  const TodoError(super.todos, super.page, super.limit, super.message);
}
