part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventLoadHistory extends SearchEvent {}

class SearchEventAddHistory extends SearchEvent {}

class SearchEventToggleHistoryExpand extends SearchEvent {}

class SearchEventAddQuery extends SearchEvent {
  final String query;

  const SearchEventAddQuery(this.query);

  @override
  List<Object> get props => [query];
}

class SearchEventClearHistory extends SearchEvent {}

class SearchEventLoadSuggestions extends SearchEvent {}
