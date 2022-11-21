import 'package:demo/helpers/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.historyRepository) : super(SearchInitial()) {
    on<SearchEventLoadHistory>(_onSearchEventLoadHistory,
        transformer: throttleDroppable(throttleDuration));
    on<SearchEventAddHistory>(_onSearchEventAddHistory,
        transformer: throttleDroppable(throttleDuration));
    on<SearchEventClearHistory>(_onSearchEventClearHistory,
        transformer: throttleDroppable(throttleDuration));
    on<SearchEventAddQuery>(_onSearchEventAddQuery,
        transformer: throttleDroppable(throttleDuration));
    on<SearchEventToggleHistoryExpand>(_onSearchEventToggleHistoryExpand,
        transformer: throttleDroppable(throttleDuration));
  }
  final HistoryRepository historyRepository;

  Future<void> _onSearchEventLoadHistory(
    SearchEventLoadHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(state.copyWith(isFetching: true));
      final history = await historyRepository.getHistory();
      return emit(state.copyWith(
        status: SearchStatus.success,
        history: history,
        isFetching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }

  Future<void> _onSearchEventAddHistory(
    SearchEventAddHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (state.query == null || state.query!.isEmpty) {
        return;
      }
      emit(state.copyWith(isFetching: true));
      await historyRepository.addHistory(state.query!);
      final history = await historyRepository.getHistory();
      return emit(state.copyWith(
        status: SearchStatus.success,
        history: history,
        isFetching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }

  Future<void> _onSearchEventClearHistory(
    SearchEventClearHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(state.copyWith(isFetching: true));
      await historyRepository.clearHistory();
      return emit(state.copyWith(
        status: SearchStatus.success,
        history: [],
        isFetching: false,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }

  Future<void> _onSearchEventAddQuery(
    SearchEventAddQuery event,
    Emitter<SearchState> emit,
  ) async {
    return emit(state.copyWith(
      query: event.query,
    ));
  }

  Future<void> _onSearchEventToggleHistoryExpand(
    SearchEventToggleHistoryExpand event,
    Emitter<SearchState> emit,
  ) async {
    return emit(state.copyWith(
      isHistoryExpanded: !state.isHistoryExpanded,
    ));
  }
}
