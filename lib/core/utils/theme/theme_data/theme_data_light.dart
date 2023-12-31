import 'package:flutter/material.dart';
import '../app_color/app_color_light.dart';

ThemeData getThemeDataLight = ThemeData(
    //theme بتاع ال text كله
    primaryColor: AppColorsLight.primaryColor,
    appBarTheme: const AppBarTheme(elevation: 0,backgroundColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
// بيسمع فى كل ال app من غير متعمل style فى ال TextButton
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColorsLight.primaryColor)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: AppColorsLight.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColorsLight.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColorsLight.primaryColor),
    ));
// ThemeData getThemeDataLight()=>ThemeData.light().copyWith();
