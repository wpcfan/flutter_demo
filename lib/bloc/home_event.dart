part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent(this.platform);
  final String platform;
  @override
  List<Object> get props => [platform];
}

class HomeFetched extends HomeEvent {
  const HomeFetched(super.platform);
}
