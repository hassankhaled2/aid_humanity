import 'package:aid_humanity/Features/home/presentation/views/home_view.dart';
import 'package:aid_humanity/Features/profile/presentation/pages/profile_page.dart';
import 'package:aid_humanity/core/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      supportedLocales: const [Locale('en'), Locale('ar')], // this line to provie , which langs to use in our app
      localizationsDelegates: [
        AppLocalizations.delegate, // this line for adding our localization class.
        GlobalMaterialLocalizations.delegate, //translate some widgets by it self to diff (like dialogs).
        GlobalWidgetsLocalizations.delegate, //reponsaple for change direction of the widget based on the current widget.
        GlobalCupertinoLocalizations.delegate, //translate some widgets by it self to diff lang.
      ],

      theme: getThemeDataLight(context),
      home: const ProfilePage(), //const HomeView(),

    );
  }
}
