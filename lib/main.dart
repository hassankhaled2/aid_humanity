
import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';


void main() async {
  //the WidgetFlutterBinding is used to interact with the Flutter engine
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:AppRouter.router,
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizationsSetup.supportedLocales, // this line to provie , which langs to use in our app
      localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return AppLocalizationsSetup.localeResolutionCallback(deviceLocale!, supportedLocales);
      },
      theme: getThemeDataLight, //const HomeView(),
    );
  }
}
