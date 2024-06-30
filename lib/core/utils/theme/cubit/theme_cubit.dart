import 'dart:io';

import 'package:aid_humanity/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../App_theme.dart';
import '../theme_cache_helper.dart';

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

  getCurrentTheme()async
  {
    final themeIndex = await ThemeCacheHelper().getCachedThemeIndex();
    // here make equal the number of index (map) to the number of that saved in sharedPreference
    final theme= AppTheme.values.firstWhere((appTheme) => appTheme.index == themeIndex);
    emit(LoadedThemeState(themeData: appThemeData[theme]!));
  }
  changeTheme(AppTheme appTheme)async
  {
    final themeIndex = appTheme.index;
    await ThemeCacheHelper().cacheThemeIndex(themeIndex);
    //here we will pass the value of the enum we have & make rebuild
    emit(LoadedThemeState(themeData: appThemeData[appTheme]!));
  }

}
