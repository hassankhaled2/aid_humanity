import 'package:flutter/material.dart';
import '../app_color/app_color_light.dart';

ThemeData getThemeDataLight()=>ThemeData(
  //theme بتاع ال text كله
  primaryColor:AppColorsLight.primaryColor,
    textButtonTheme: TextButtonThemeData(
// بيسمع فى كل ال app من غير متعمل style فى ال TextButton
   style:ButtonStyle (
       foregroundColor:MaterialStateProperty.all(Color(0xFFF8B145))
   ),


),
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(selectedItemColor:AppColorsLight.bottomNavigationBarColor) ,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor:AppColorsLight.floatingActionButtonColor
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF7B245)
    ),
  )

);
// ThemeData getThemeDataLight()=>ThemeData.light().copyWith();