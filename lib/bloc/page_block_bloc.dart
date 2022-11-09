import 'package:demo/helpers/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_block_event.dart';
part 'page_block_state.dart';

class PageBlockBloc extends Bloc<PageBlockEvent, PageBlockState> {
  final PageBlockRepository repository;
  PageBlockBloc({required this.repository}) : super(const PageBlockState()) {
    on<PageBlockEvent>(_onPageBlockEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPageBlockEvent(
    PageBlockEvent event,
    Emitter<PageBlockState> emit,
  ) async {
    try {
      emit(state.copyWith(isFetching: true));
      final pageBlocks = await repository.getPageBlocks();
      return emit(PageBlockState(
        status: PageBlockStatus.success,
        pageBlocks: pageBlocks,
        isFetching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PageBlockStatus.failure,
        error: e.toString(),
        isFetching: false,
      ));
    }
  }
}
