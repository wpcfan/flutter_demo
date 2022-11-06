import 'dart:async';

import 'package:demo/config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_events.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashStart>(_onSplashStart);
    on<SplashStop>(_onSplashStop);
    on<SplashCountdown>(_onSplashCountdown);
    add(const SplashStart(splashDuration));
  }

  void _onSplashStart(SplashStart event, Emitter<SplashState> emit) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick >= event.duration) {
        timer.cancel();
        add(const SplashStop());
      } else {
        add(SplashCountdown(event.duration - timer.tick));
      }
      debugPrint(
          'timer tick: ${timer.tick}, state count: ${state.count}, event duration: ${event.duration}');
    });
  }

  void _onSplashCountdown(SplashCountdown event, Emitter<SplashState> emit) {
    emit(SplashCounting(count: event.count));
  }

  void _onSplashStop(SplashStop event, Emitter<SplashState> emit) {
    emit(const SplashComplete());
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  void onChange(Change<SplashState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<SplashEvent, SplashState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
