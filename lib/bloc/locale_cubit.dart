import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences perfs;

  LocaleCubit({required this.perfs}) : super(const Locale('en')) {
    final languageCode = perfs.getString('locale');
    if (languageCode != null) {
      emit(Locale(languageCode));
    } else {
      perfs.setString('locale', 'en');
    }
  }

  void changeLocale(Locale locale) {
    perfs.setString('locale', locale.languageCode);
    emit(locale);
  }
}
