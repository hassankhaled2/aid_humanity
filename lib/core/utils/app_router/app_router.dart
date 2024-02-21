import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/delivery_view_details.dart';
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//  تقدر تعرف كل ال screens الرئسيه اللى فى الApp من خلال ال class ده

abstract class AppRouter {
  // بنعمل الحركه دى علشان نتفادى الاخطاء الكتابيه
  static const kHomeView = '/homeView';
  static const kDeliveryViewDetails = '/deliveryViewDetails';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        //نقطه البدايه بتاعته ال / <--
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const BottomNavigation(),
      ),
      GoRoute(
        //   //  أل path ده علشان تروح على ال widget اللى انت عايزها من خلال call اللى بتعمله
        path: kDeliveryViewDetails,
        builder: (BuildContext context, GoRouterState state) => const DeliveryViewDetails(),
      ),
      GoRoute(
        //  أل path ده علشان تروح على ال widget اللى انت عايزها من خلال call اللى بتعمله
        path:kDeliveryViewDetails ,
        builder: (BuildContext context, GoRouterState state) =>const DeliveryViewDetails(),
      ),

    ],
  );
}
