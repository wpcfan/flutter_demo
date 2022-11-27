import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.repository, required this.prefs})
      : super(RegisterInitial());
  final AuthRepository repository;
  final SharedPreferences prefs;

  void register(String username, String password, String phone) async {
    emit(RegisterLoading());
    try {
      final user = await repository.register(username, password, phone);
      if (user.sessionToken != null) {
        prefs.setString('sessionToken', user.sessionToken!);
        emit(RegisterSuccess(user: user));
      } else {
        emit(RegisterError('Something went wrong'));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
