import 'package:aid_humanity/Features/auth/data/data_sources/login_remote_data_source/auth_remote_data_source.dart';
import 'package:aid_humanity/Features/auth/data/repositeries_impl/auth_repo_impl.dart';
import 'package:aid_humanity/Features/auth/domain/entites/user_entity.dart';
import 'package:aid_humanity/Features/auth/domain/use_cases_impl/login_with_google_use_case.dart';
import 'package:aid_humanity/Features/auth/domain/use_cases_impl/post_user_data_use_case.dart';
import 'package:aid_humanity/Features/auth/presentation/cubit/auth_login_cubit/auth_login_cubit.dart';
import 'package:aid_humanity/Features/auth/presentation/pages/register_page.dart';
import 'package:aid_humanity/Features/choose%20page/choose_page.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';

import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_delivery_page.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_donor_page.dart';
import 'package:aid_humanity/Features/onBoarding/onboarding.dart';
import 'package:aid_humanity/Features/spalsh/spalsh.dart';
import 'package:aid_humanity/bloc_observer.dart';
import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/injection_container.dart' as di;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'Features/auth/presentation/pages/login_page.dart';
import 'core/constants/constants.dart';
import 'core/network/connection/network_connection.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';
import 'core/widgets/BottomNavigation.dart';
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

        )

        // BlocProvider.value(
        //     value: AuthLoginCubit(CallLoginWithGoogleUseCase(getIt.get<AuthRepoImpl>())),
        //
        // )
      ],
      child: MaterialApp(
        routes: routes,

        /// see it if worked or not
        home:  FirebaseAuth.instance.currentUser!=null&&(FirebaseAuth.instance.currentUser!.emailVerified||FirebaseAuth.instance.currentUser!.phoneNumber!=null)?BottomNavigation():SplashScreen(),
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
