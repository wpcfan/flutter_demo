import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences perfs;

  LocaleCubit({required this.perfs}) : super(const Locale('en')) {
    final locale = perfs.getString('locale');
    if (locale != null) {
      emit(Locale(locale));
    } else {
      perfs.setString('locale', 'en');
    }
  }

  void changeLocale(String languageCode) {
    perfs.setString('locale', languageCode);
    emit(Locale(languageCode));
  }
}
