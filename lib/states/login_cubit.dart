import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final usernameController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  Stream<String> get usernameStream => usernameController.stream;
  Stream<String> get passwordStream => passwordController.stream;

  void updateUsername(String username) {
    if (username.length < 4) {
      usernameController.sink
          .addError('Username must be at least 4 characters');
    } else {
      usernameController.sink.add(username);
    }
  }

  void updatePassword(String password) {
    if (password.length < 4) {
      passwordController.sink
          .addError('Password must be at least 4 characters');
    } else {
      passwordController.sink.add(password);
    }
  }

  Stream<bool> get submitValid =>
      Rx.combineLatest2(usernameStream, passwordStream, (a, b) => true);
}
