
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//  تقدر تعرف كل ال screens الرئسيه اللى فى الApp من خلال ال class ده

abstract class AppRouter {
  // بنعمل الحركه دى علشان نتفادى الاخطاء الكتابيه
  static const kHomeView = '/homeView';
  static const kViewDetails = '/viewDetailsPage';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        //نقطه البدايه بتاعته ال / <--
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const BottomNavigation(),
      ),

    ],
  );
}
