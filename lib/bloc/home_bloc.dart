import 'package:demo/helpers/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PageBlockRepository repository;
  HomeBloc({required this.repository}) : super(const HomeState()) {
    on<HomeEvent>(_onPageBlockEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPageBlockEvent(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(isFetching: true));
      final pageBlocks = await repository.getPageBlocks(event.platform, 'home');
      return emit(HomeState(
        status: BlocStatus.success,
        pageBlocks: pageBlocks,
        isFetching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }
}
