import 'package:aid_humanity/Features/auth/presentation/widgets/circle_avatar_widget.dart';

import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDelivery.dart';
import 'package:flutter/material.dart';

import '../../Features/auth/presentation/pages/login_page.dart';
import '../../Features/auth/presentation/pages/register_page.dart';


import '../../Features/home/presentation/pages/choice_page.dart';
import '../../Features/home/presentation/pages/home_delivery_page.dart';
import '../../Features/home/presentation/pages/home_donor_page.dart';
import '../../Features/onBoarding/onboarding.dart';
import 'BottomNavigationDonor.dart';


Map<String,Widget Function(BuildContext)>routes=
{
  // AppRouter.splash : (context) => SplashScreen() ,
  AppRouter. login : (context) => LoginPage(),
  AppRouter.register : (context) => RegisterPage() ,
  AppRouter.bottomNavigationDonor : (context) => BottomNavigationDonor(),
  AppRouter.bottomNavigationDelivery : (context) => BottomNavigationDelivery(),

  AppRouter. onBoarding:(context)=>OnBoarding(),
  AppRouter. choicePage:(context)=>ChoicePage(),
  AppRouter. homeDeliveryPage:(context)=>HomeDeliveryPage(),
  AppRouter.homeDonorPage:(context)=>HomeDonorPage(),
  AppRouter.circleAvatarProfile:(context)=>CircleAvatarWidget(),
};
