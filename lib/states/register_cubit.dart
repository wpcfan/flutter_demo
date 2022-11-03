import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.repository}) : super(RegisterInitial());
  final AuthRepository repository;

  void register(String username, String password, String phone) async {
    emit(RegisterLoading());
    try {
      final user = await repository.register(username, password, phone);
      emit(RegisterSuccess(user: user));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
