part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;
  RegisterSuccess({required this.user});
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
