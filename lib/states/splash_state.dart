part of 'splash_cubit.dart';

@immutable
class SplashState {
  final int count;
  const SplashState({required this.count});

  SplashState copyWith({int? count}) {
    return SplashState(count: count ?? this.count);
  }
}

class SplashInitial extends SplashState {
  const SplashInitial() : super(count: 5);
}

class SplashCountdown extends SplashState {
  const SplashCountdown({required int count}) : super(count: count);
}

class SplashComplete extends SplashState {
  const SplashComplete() : super(count: 0);
}
