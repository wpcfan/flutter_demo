import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  void countdown() {
    Stream.periodic(const Duration(seconds: 1), (x) => x)
        .take(state.count)
        .map((count) => SplashCountdown(count: state.count - count - 1))
        .listen((state) => emit(state));
  }

  void complete() {
    emit(const SplashComplete());
  }
}
