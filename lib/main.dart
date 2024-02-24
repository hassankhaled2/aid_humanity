import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';
import 'package:aid_humanity/Features/home/data/data_sources/remote_data_source.dart';
import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/bloc_observer.dart';
import 'package:aid_humanity/core/utils/Localization/app_localization_setup.dart';
import 'package:aid_humanity/injection_container.dart' as di;
import 'package:aid_humanity/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'Features/auth/presentation/pages/login_page.dart';
import 'core/utils/theme/theme_data/theme_data_light.dart';
import 'core/widgets/BottomNavigation.dart';

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
        BlocProvider(create: (_) => di.getIt<HomeBloc>()..add(GetAllRequestsEvent())),
      ],
      child: MaterialApp(
        home: FirebaseAuth.instance.currentUser == null ? const LoginPage() : const BottomNavigation(),
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocalizationsSetup.supportedLocales, // this line to provide , which langs to use in our app
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          return AppLocalizationsSetup.localeResolutionCallback(deviceLocale!, supportedLocales);
        },
        theme: getThemeDataLight, //const HomeView(),
      ),
    );
  }
}

Future<Position> getPosition() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemarks[0].street);
  print(placemarks[0].locality);
  return position;
}
