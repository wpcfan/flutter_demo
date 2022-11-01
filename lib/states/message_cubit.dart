import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<String?> {
  MessageCubit() : super(null);

  void showMessage() => emit(state);
}
