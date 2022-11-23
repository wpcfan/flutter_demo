part of 'page_block_bloc.dart';

abstract class PageBlockEvent extends Equatable {
  const PageBlockEvent(this.platform, this.target);
  final String platform;
  final String target;
  @override
  List<Object> get props => [platform, target];
}

class PageBlockFetched extends PageBlockEvent {
  const PageBlockFetched(super.platform, super.target);
}
