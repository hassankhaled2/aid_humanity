// ignore_for_file: library_private_types_in_public_api

import 'package:aid_humanity/core/constants/cachehelper/cacheHelper.dart';
import 'package:aid_humanity/core/constants/componants.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModels {
  final String image;
  final String title;
  final String body;
  final MaterialButton? welcomeButton;

  BoardingModels({
    required this.image,
    required this.title,
    required this.body,
    this.welcomeButton,
  });
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardingController = PageController();

  List<BoardingModels> boarding = [
    BoardingModels(
      image: 'assets/images/onboarding1.png',
      title: '',
      body: 'Feeding Hope, One Helping Hand at a Time.',
    ),
    BoardingModels(
      image: 'assets/images/onboarding2.png',
      title: 'Together, we can make a difference! Help us fight hunger',
      body:
          'Your contribution can make a big difference in the lives of those in need.',
    ),
    BoardingModels(
      image: 'assets/images/onboardingWelcom.png',
      title: '',
      body:
          'Welcome to ResoKitchen Connecting Communities, Sharing Meals', //Join our community and start sharing meals today.
      welcomeButton: MaterialButton(
        onPressed: () {},
        
        color: Colors.transparent,
        textColor: AppColorsLight.primaryColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text('Get Started',
        style: TextStyle
        ( fontSize: 15.0,
          

        ),
        ),
      ),
    ),
  ];

  int index = 0;
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value = isLast) {
        navigateAndFinish(
          context,
          const BottomNavigation(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColorsLight.dividerColor,
        actions: [
          TextButton(
            onPressed: () {
              navigateAndFinish(
                context,
                const BottomNavigation(),
              );
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(30.0),
        child: Column(
          
          children: [
            const SizedBox(height: 25.0),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int newIndex) {
                  index = newIndex;
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], index++),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40.0),
            Visibility(
              visible: !isLast,
              child: Row(
                children: [
                  SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      dotColor: AppColorsLight.dividerColor,
                      activeDotColor: AppColorsLight.primaryColor,
                      dotHeight: 15,
                      dotWidth: 15,
                      expansionFactor: 5,
                      spacing: 2,
                    ),
                    controller: boardingController,
                    count: boarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    child: const Icon(Icons.east),
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                        index++;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModels models, int index) {
    if (index == boarding.length - 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            models.body,
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          Image(image: AssetImage(models.image)),
          const SizedBox(height: 100.0),
          Container(
             
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColorsLight.primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.transparent,
              ),
                child: MaterialButton(
    onPressed: () {
      submit();
      index++;
    },
    child: const Text(
      'Get Started',
      style: TextStyle(
        fontSize: 30.0,
          
        color: AppColorsLight.primaryColor,
      ),
    ),
  ),
),
              
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Text(
            models.body,
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          const SizedBox(height: 40.0),
          Expanded(child: Image(image: AssetImage(models.image))),
          const SizedBox(height: 40.0),
          if (models.welcomeButton != null) models.welcomeButton!,
          if (models.welcomeButton == null)
            MaterialButton(
              onPressed: () {
                submit();
                index++;
              },
            ),
        ],
      );
    }
  }
}
