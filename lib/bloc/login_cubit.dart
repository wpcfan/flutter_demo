import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repository, required this.prefs})
      : super(LoginInitial());
  final AuthRepository repository;
  final SharedPreferences prefs;

  void login(String username, String password) async {
    emit(LoginLoading());
    try {
      final user = await repository.login(username, password);
      if (user.sessionToken != null) {
        prefs.setString('sessionToken', user.sessionToken!);
        prefs.setString('cartId', user.sessionToken!);
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginError('Something went wrong'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
