part of 'search_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.query,
    this.history = const [],
    this.pageBlocks = const [],
    this.error,
    this.historyStatus = SearchStatus.initial,
    this.suggestionsStatus = SearchStatus.initial,
    this.isFetching = false,
    this.isHistoryExpanded = false,
  });
  final String? query;
  final List<String> history;
  final List<PageBlock> pageBlocks;
  final String? error;
  final SearchStatus historyStatus;
  final SearchStatus suggestionsStatus;
  final bool isFetching;
  final bool isHistoryExpanded;
  @override
  List<Object?> get props => [
        history,
        pageBlocks,
        error,
        historyStatus,
        suggestionsStatus,
        isFetching,
        query,
        isHistoryExpanded,
      ];

  SearchState copyWith({
    List<String>? history,
    List<PageBlock>? pageBlocks,
    String? error,
    SearchStatus? historyStatus,
    SearchStatus? suggestionsStatus,
    bool? isFetching,
    String? query,
    bool? isHistoryExpanded,
  }) {
    return SearchState(
      history: history ?? this.history,
      pageBlocks: pageBlocks ?? this.pageBlocks,
      error: error ?? this.error,
      historyStatus: historyStatus ?? this.historyStatus,
      suggestionsStatus: suggestionsStatus ?? this.suggestionsStatus,
      isFetching: isFetching ?? this.isFetching,
      query: query ?? this.query,
      isHistoryExpanded: isHistoryExpanded ?? this.isHistoryExpanded,
    );
  }

  @override
  String toString() {
    return '''SearchState {
      history: ${history.length},
      pageBlocks: ${pageBlocks.length},
      historyStatus: $historyStatus,
      suggestionsStatus: $suggestionsStatus,
      error: $error,
      isFetching: $isFetching,
      query: $query,
      isHistoryExpanded: $isHistoryExpanded,
    }''';
  }
}

class SearchInitial extends SearchState {}
