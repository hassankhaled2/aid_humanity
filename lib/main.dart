
import 'package:aid_humanity/Feature/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:getThemeDataLight(),
      home: const HomeView(),
    );
  }
}


