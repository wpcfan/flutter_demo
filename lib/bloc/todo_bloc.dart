import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc({required this.repository}) : super(const TodoState()) {
    on<TodoFetchedEvent>(_onTodoFetchedEvent);
    on<TodoRefreshEvent>(_onTodoRefreshEvent);
    on<TodoToggleEvent>(_onTodoToggleEvent);
  }

  Future<void> _onTodoFetchedEvent(
    TodoFetchedEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == TodoStatus.initial) {
        final todos = await repository.getTodos();
        return emit(TodoState(
          status: TodoStatus.success,
          todos: todos,
          hasReachedMax: false,
        ));
      }
      final todos = await repository.getTodos(state.todos.length);
      emit(todos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : TodoState(
              status: TodoStatus.success,
              todos: [...state.todos, ...todos],
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(TodoState(status: TodoStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onTodoRefreshEvent(
    TodoRefreshEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final todos = await repository.getTodos();
      emit(TodoState(
        status: TodoStatus.success,
        todos: todos,
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(TodoState(status: TodoStatus.failure, error: e.toString()));
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
      emit(TodoState(
        status: TodoStatus.success,
        todos: todos,
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(TodoState(status: TodoStatus.failure, error: e.toString()));
    }
  }
}
