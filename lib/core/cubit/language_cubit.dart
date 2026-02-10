import 'package:evently/core/helper/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String _languageKey = 'app_language';

  LanguageCubit() : super(const Locale('en')) {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final savedLanguage = CacheHelper.getData(key: _languageKey);
    if (savedLanguage != null) {
      emit(Locale(savedLanguage));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper.saveData(key: _languageKey, value: languageCode);
    emit(Locale(languageCode));
  }

  bool get isEnglish => state.languageCode == 'en';
  bool get isArabic => state.languageCode == 'ar';
}
