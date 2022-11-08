import 'package:demo/helpers/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc({required this.repository}) : super(const TodoState()) {
    on<TodoFetchedEvent>(_onTodoFetchedEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TodoRefreshEvent>(_onTodoRefreshEvent,
        transformer: throttleDroppable(throttleDuration));
    on<TodoToggleEvent>(_onTodoToggleEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onTodoFetchedEvent(
    TodoFetchedEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == TodoStatus.initial) {
        emit(state.copyWith(isFetching: true));
        final todos = await repository.getTodos();
        return emit(TodoState(
          status: TodoStatus.success,
          todos: todos,
          hasReachedMax: false,
          isFetching: false,
        ));
      }
      emit(state.copyWith(isFetching: true));
      final todos = await repository.getTodos(state.todos.length);
      emit(todos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: TodoStatus.success,
              todos: List.of(state.todos)..addAll(todos),
              hasReachedMax: false,
              isFetching: false,
            ));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onTodoRefreshEvent(
    TodoRefreshEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, status: TodoStatus.initial));
    try {
      final todos = await repository.getTodos();
      emit(TodoState(
        status: TodoStatus.success,
        todos: todos,
        hasReachedMax: false,
        isRefreshing: false,
      ));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onTodoToggleEvent(
    TodoToggleEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final todo = await repository.updateTodoById(event.todo.id!,
          event.todo.copyWith(completed: !event.todo.completed));
      final todos = state.todos.map((t) => t.id == todo.id ? todo : t).toList();
      emit(state.copyWith(
        status: TodoStatus.success,
        todos: todos,
      ));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, error: e.toString()));
    }
  }
}
