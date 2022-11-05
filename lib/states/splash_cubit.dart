import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  void countdown() {
    if (state.count > 0) {
      emit(SplashCountdown(count: state.count - 1));
    } else {
      emit(const SplashComplete());
    }
  }
}
