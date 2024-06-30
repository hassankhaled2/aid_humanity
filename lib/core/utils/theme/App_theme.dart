import 'package:flutter/material.dart';

import 'app_color/app_color_light.dart';

enum AppTheme {
  light("Light"),
  dark("Dark");


  const AppTheme(this.name);
  final String name;
}
// This is map represent key & value
final appThemeData = {
  AppTheme.light:ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFF8B145),
    appBarTheme: const AppBarTheme(elevation: 0,backgroundColor: Colors.white),
   textButtonTheme: TextButtonThemeData(
// بيسمع فى كل ال app من غير متعمل style فى ال TextButton
style: ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColorsLight.primaryColor)),
),
bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: AppColorsLight.primaryColor),
floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColorsLight.primaryColor),
elevatedButtonTheme: ElevatedButtonThemeData(
style: ElevatedButton.styleFrom(backgroundColor: AppColorsLight.primaryColor),
  ),
  ),
  AppTheme.dark:ThemeData(
    appBarTheme:  AppBarTheme(elevation: 0,color: Colors.black12),
    brightness: Brightness.dark,

    primaryColor: Color(0xFFF8B145),
    textButtonTheme: TextButtonThemeData(
// بيسمع فى كل ال app من غير متعمل style فى ال TextButton
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColorsLight.primaryColor)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: AppColorsLight.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColorsLight.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColorsLight.primaryColor),
    ),
  ),

};