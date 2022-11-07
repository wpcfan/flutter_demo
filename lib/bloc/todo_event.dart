part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoFetchedEvent extends TodoEvent {}

class TodoRefreshEvent extends TodoEvent {}

class TodoToggleEvent extends TodoEvent {
  final Todo todo;

  const TodoToggleEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
