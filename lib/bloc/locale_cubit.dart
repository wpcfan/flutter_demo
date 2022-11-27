import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences prefs;

  LocaleCubit({required this.prefs}) : super(const Locale('en')) {
    final languageCode = prefs.getString('locale');
    if (languageCode != null) {
      emit(Locale(languageCode));
    } else {
      prefs.setString('locale', 'en');
    }
  }

  void changeLocale(Locale locale) {
    prefs.setString('locale', locale.languageCode);
    emit(locale);
  }
}
