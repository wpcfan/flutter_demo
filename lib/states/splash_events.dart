part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashStart extends SplashEvent {
  const SplashStart(this.duration);
  final int duration;
}

class SplashStop extends SplashEvent {
  const SplashStop();
}

class SplashCountdown extends SplashEvent {
  const SplashCountdown(this.count);
  final int count;
}
