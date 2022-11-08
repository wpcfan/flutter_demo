part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  final List<Todo> todos;
  final String? error;
  final TodoStatus status;
  final bool hasReachedMax;
  const TodoState({
    this.todos = const [],
    this.hasReachedMax = false,
    this.error,
    this.status = TodoStatus.initial,
  });

  @override
  List<Object> get props => [todos, hasReachedMax, status];

  TodoState copyWith({
    List<Todo>? todos,
    bool? hasReachedMax,
    String? error,
    TodoStatus? status,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'TodoState { todos: ${todos.length}, hasReachedMax: $hasReachedMax, status: $status, error: $error }';
}
