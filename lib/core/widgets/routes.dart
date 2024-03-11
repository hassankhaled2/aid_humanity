import 'package:aid_humanity/Features/spalsh/spalsh.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:flutter/material.dart';

import '../../Features/auth/presentation/pages/login_page.dart';
import '../../Features/auth/presentation/pages/register_page.dart';
import '../../Features/choose page/choose_page.dart';
import '../../Features/home/presentation/pages/home_delivery_page.dart';
import '../../Features/home/presentation/pages/home_donor_page.dart';
import '../../Features/onBoarding/onboarding.dart';
import 'BottomNavigation.dart';

Map<String,Widget Function(BuildContext)>routes=
{
  // AppRouter.splash : (context) => SplashScreen() ,
  AppRouter. login : (context) => LoginPage(),
  AppRouter.register : (context) => RegisterPage() ,
  AppRouter. bottomNavigation : (context) => BottomNavigation(),
  AppRouter. onBoarding:(context)=>OnBoarding(),
  // AppRouter. choicePage:(context)=>ChoicePage(),
  AppRouter. homeDeliveryPage:(context)=>HomeDeliveryPage(),
  AppRouter.homeDonorPage:(context)=>HomeDonorPage(),
};
