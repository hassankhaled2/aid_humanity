import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localization.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate, // this one for change the direction of the widgets based on the language
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate, //this one for translate some widgets in the app by it self
  ];

  static Locale localeResolutionCallback(Locale deviceLocale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      // ignore: unnecessary_null_comparison
      if (deviceLocale != null && supportedLocale.languageCode == deviceLocale.languageCode) {
        return deviceLocale;
      }
    }
    return supportedLocales.first;
  }
}
