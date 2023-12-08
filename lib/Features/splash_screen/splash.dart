// ignore_for_file: override_on_non_overriding_member

import 'package:aid_humanity/Features/onboarding/onboardingWidgets/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 1), () {
  

      // Push the onboarding screen onto the navigation stack
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const OnBoarding(),
        ),
      );
    });
  }
  @override 
   void dipose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
     overlays: SystemUiOverlay.values);
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFffbd59), Color(0xFFff914d)],
            begin: Alignment.center,
            end: Alignment.topCenter,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help_center,
              size: 70.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "AID HUMMANITY",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
