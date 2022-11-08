part of 'page_block_bloc.dart';

abstract class PageBlockEvent extends Equatable {
  const PageBlockEvent();

  @override
  List<Object> get props => [];
}

class PageBlockFetched extends PageBlockEvent {}
