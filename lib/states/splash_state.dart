part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable {
  final int count;
  const SplashState({required this.count});
}

class SplashInitial extends SplashState {
  const SplashInitial() : super(count: splashDuration);
  @override
  List<Object?> get props => [];
}

class SplashCounting extends SplashState {
  const SplashCounting({required int count}) : super(count: count);

  @override
  List<Object?> get props => [count];
}

class SplashComplete extends SplashState {
  const SplashComplete() : super(count: 0);

  @override
  List<Object?> get props => [];
}
