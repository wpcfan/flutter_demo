part of 'search_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.query,
    this.history = const [],
    this.error,
    this.status = SearchStatus.initial,
    this.isFetching = false,
    this.isHistoryExpanded = false,
  });
  final String? query;
  final List<String> history;
  final String? error;
  final SearchStatus status;
  final bool isFetching;
  final bool isHistoryExpanded;
  @override
  List<Object?> get props => [
        history,
        error,
        status,
        isFetching,
        query,
        isHistoryExpanded,
      ];

  SearchState copyWith({
    List<String>? history,
    String? error,
    SearchStatus? status,
    bool? isFetching,
    String? query,
    bool? isHistoryExpanded,
  }) {
    return SearchState(
      history: history ?? this.history,
      error: error ?? this.error,
      status: status ?? this.status,
      isFetching: isFetching ?? this.isFetching,
      query: query ?? this.query,
      isHistoryExpanded: isHistoryExpanded ?? this.isHistoryExpanded,
    );
  }

  @override
  String toString() {
    return '''SearchState {
      history: ${history.length},
      status: $status,
      error: $error,
      isFetching: $isFetching,
      query: $query,
      isHistoryExpanded: $isHistoryExpanded,
    }''';
  }
}

class SearchInitial extends SearchState {}
