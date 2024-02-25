
import 'package:aid_humanity/Features/auth/presentation/pages/register_page.dart';
import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Features/auth/presentation/pages/login_page.dart';
import 'Features/auth/presentation/pages/phone_number_page.dart';
import 'core/utils/app_router/app_router.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';
import 'core/widgets/BottomNavigation.dart';




void main() async {
  //the WidgetFlutterBinding is used to interact with the Flutter engine
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
       name: "initial",
        options: FirebaseOptions(

          apiKey: "XXX",
          appId: "1:676376055999:android:3e1856eebf7a5388e0360a",
          messagingSenderId: "676376055999 ",
          projectId: "aid-humanity-2221d",
    ),
    );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('--------User is currently signed out!');
      } else {
        print('--------User is signed in!');
      }
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:
      {
        register : (context) => RegisterPage() ,
        login : (context) => LoginPage(),
        bottomNavigation : (context) => BottomNavigation(),
      },
      /// see it if worked or not
      home: FirebaseAuth.instance.currentUser!=null&&(FirebaseAuth.instance.currentUser!.emailVerified||FirebaseAuth.instance.currentUser!.phoneNumber!=null)?BottomNavigation():LoginPage(),
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
