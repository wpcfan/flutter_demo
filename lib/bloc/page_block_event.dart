part of 'page_block_bloc.dart';

abstract class PageBlockEvent extends Equatable {
  const PageBlockEvent(this.platform);
  final String platform;
  @override
  List<Object> get props => [platform];
}

class PageBlockFetched extends PageBlockEvent {
  const PageBlockFetched(super.platform);
}
