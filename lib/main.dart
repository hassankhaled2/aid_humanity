import 'package:aid_humanity/Features/auth/data/repositeries_impl/auth_repo_impl.dart';
import 'package:aid_humanity/Features/auth/domain/use_cases_impl/login_with_google_use_case.dart';
import 'package:aid_humanity/Features/auth/presentation/cubit/auth_login_cubit/auth_login_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';

import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/bloc_observer.dart';
import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:aid_humanity/injection_container.dart' as di;
import 'package:aid_humanity/test_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Circule_widget_Testing/cubit/testing_cubit.dart';
import 'Circule_widget_Testing/testing_choose.dart';
import 'Features/auth/presentation/cubit/test_cubit.dart';
import 'Features/auth/presentation/pages/circle_avatar_widget.dart';
import 'Features/auth/presentation/pages/register_page.dart';
import 'Features/donation_details/presentaion/pages/choose_items_page.dart';
import 'Features/home/presentation/pages/choice_page.dart';
import 'Features/home/presentation/widgets/choise_Item.dart';
import 'Features/spalsh/spalsh.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';
import 'core/widgets/BottomNavigationDonor.dart';
import 'core/widgets/routes.dart';
import 'injection_container.dart';

void main() async {
  //the WidgetFlutterBinding is used to interact with the Flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "initial",
    options: const FirebaseOptions(
      apiKey: "XXX",
      appId: "1:676376055999:android:3e1856eebf7a5388e0360a",
      messagingSenderId: "676376055999 ",
      projectId: "aid-humanity-2221d",
    ),
  );
  // await FirebaseAppCheck.instance.activate(
  //   // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
  //   // argument for `webProvider`
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. Debug provider
  //   // 2. Safety Net provider
  //   // 3. Play Integrity provider
  //   androidProvider: AndroidProvider.debug,
  //   // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. Debug provider
  //   // 2. Device Check provider
  //   // 3. App Attest provider
  //   // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
  //   appleProvider: AppleProvider.appAttest,
  // );


  await di.init();


  Bloc.observer = MyBlocObserver();



  runApp(MyApp());
  // Hive.registerAdapter(UserEntityAdapter());
  // Hive.openBox(KFearured);
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<DetailsBloc>()),
        BlocProvider(
            create: (_) => di.getIt<HomeBloc>()..add(GetAllRequestsEvent())),
        BlocProvider(create: (_) => ClassificaitonCubit()),
        BlocProvider(
            create: (context)
        {
          return AuthLoginCubit(CallLoginWithGoogleUseCase(getIt.get<AuthRepoImpl>()));
        }

        ),


        // BlocProvider(
        // create: (context) => ImageCubit()),

        // BlocProvider.value(
        //     value: AuthLoginCubit(CallLoginWithGoogleUseCase(getIt.get<AuthRepoImpl>())),
        //
        // )
      ],
      child: MaterialApp(
        routes: routes,

        /// see it if worked or not
        // home:
       // home:CircleAvatarWidget() ,
        //
        home:FirebaseAuth.instance.currentUser!=null&&(FirebaseAuth.instance.currentUser!.emailVerified||FirebaseAuth.instance.currentUser!.phoneNumber!=null)?ChoicePage():SplashScreen(),
        //FirebaseAuth.instance.currentUser!=null&&(FirebaseAuth.instance.currentUser!.emailVerified||FirebaseAuth.instance.currentUser!.phoneNumber!=null)?ChoicePage():SplashScreen(),
            //
       // FirebaseAuth.instance.currentUser!=null&&FirebaseAuth.instance.currentUser!.emailVerified ?BottomNavigationDonor():SplashScreen()    ,
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocalizationsSetup
            .supportedLocales, // this line to provide , which langs to use in our app
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          return AppLocalizationsSetup.localeResolutionCallback(
              deviceLocale!, supportedLocales);
        },
        theme: getThemeDataLight, //const HomeView(),
      ),
    );
  }
}
