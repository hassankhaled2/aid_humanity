import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';


void main() async {
<<<<<<< HEAD
WidgetsFlutterBinding.ensureInitialized();
=======
   WidgetsFlutterBinding.ensureInitialized();
>>>>>>> ae0ccd0362c12299fc3aed028f146a0a1c487061
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
      supportedLocales: AppLocalizationsSetup
          .supportedLocales, // this line to provide , which langs to use in our app
      localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return AppLocalizationsSetup.localeResolutionCallback(
            deviceLocale!, supportedLocales);
      },
<<<<<<< HEAD
      theme: getThemeDataLight,
=======
      theme: getThemeDataLight, //const HomeView(),
>>>>>>> ae0ccd0362c12299fc3aed028f146a0a1c487061
    );
  }
}
