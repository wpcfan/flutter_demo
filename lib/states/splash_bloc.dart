import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class SplashCountdown extends SplashEvent {
  const SplashCountdown();
}

class SplashComplete extends SplashEvent {
  const SplashComplete();
}

class SplashBloc extends Bloc<SplashEvent, int> {
  StreamSubscription<int>? _tickerSubscription;
  SplashBloc() : super(5) {
    on<SplashCountdown>((event, emit) {
      Stream.periodic(const Duration(seconds: 1), (x) => x)
          .take(state)
          .map((count) => state - count - 1)
          .listen((count) => emit(count));
    });
    on<SplashComplete>((event, emit) {
      emit(0);
    });
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<SplashEvent, int> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
