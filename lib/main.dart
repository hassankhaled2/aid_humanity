
import 'package:aid_humanity/Features/home/presentation/pages/home_page.dart';
import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';

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
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizationsSetup.supportedLocales, // this line to provie , which langs to use in our app
      localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return AppLocalizationsSetup.localeResolutionCallback(deviceLocale!, supportedLocales);
      },
      theme: getThemeDataLight(context),
      home: const BottomNavigation(), //const HomeView(),
    );
  }
}
