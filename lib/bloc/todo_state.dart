part of 'todo_bloc.dart';

enum TodoStatus { initial, success, failure }

class TodoState extends Equatable {
  final List<Todo> todos;
  final String? error;
  final TodoStatus status;
  final bool hasReachedMax;
  final bool isRefreshing;
  final bool isFetching;
  const TodoState({
    this.isRefreshing = false,
    this.isFetching = false,
    this.todos = const [],
    this.hasReachedMax = false,
    this.error,
    this.status = TodoStatus.initial,
  });

  @override
  List<Object?> get props =>
      [todos, hasReachedMax, status, error, isFetching, isRefreshing];

  TodoState copyWith({
    List<Todo>? todos,
    bool? hasReachedMax,
    String? error,
    TodoStatus? status,
    bool? isFetching,
    bool? isRefreshing,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      status: status ?? this.status,
      isFetching: isFetching ?? this.isFetching,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  String toString() {
    return '''TodoState {
      todos: ${todos.length},
      hasReachedMax: $hasReachedMax,
      status: $status,
      error: $error,
      isFetching: $isFetching,
      isRefreshing: $isRefreshing,
    }''';
  }
}
