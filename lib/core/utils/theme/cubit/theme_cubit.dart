import 'dart:io';

import 'package:aid_humanity/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeCubit(
    this.sharedPreferences,
  ) : super(ThemeInitial());
  Locale locale = const Locale('en');
  Future<void> getCurrentLocale() async {
    emit(ThemeLoadingState());
    if (sharedPreferences.containsKey("locale")) {
      locale = Locale(sharedPreferences.getString('locale')!);
    } else {
      final String devicelocale = Platform.localeName;
      if (devicelocale.contains("ar")) {
        locale = const Locale('ar');
         getIt<SharedPreferences>().setInt('lang', 2);
      } else {
        locale = const Locale("en");
        getIt<SharedPreferences>().setInt('lang', 1);
      }
    }
    emit(LangChangedState());
  }

  Future<void> changeLocale(Locale lc) async {
    emit(ThemeLoadingState());
    locale = lc;
    if(lc.languageCode=='en'){
      getIt<SharedPreferences>().setInt('lang', 1);
    }
    else {
      getIt<SharedPreferences>().setInt('lang', 2);
    }
    await sharedPreferences.setString("locale", lc.languageCode);
    emit(LangChangedState());
  }
}
