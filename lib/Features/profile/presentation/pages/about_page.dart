import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(context.getDefaultSize() * 2),
        child: Container(
            height: context.getDefaultSize() * 200,
            width: context.getDefaultSize() * 100,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(context.getDefaultSize())),
            child: Padding(
              padding: EdgeInsets.all(context.getDefaultSize() * 2),
              child: ListView(
                children: [
                  SizedBox(
                    height: context.getDefaultSize(),
                  ),
                  const Text(
                    "Millions of people around the world live in poverty and lack access to basic necessities such as food and clothing. While there are many charitable organizations that provide aid to these individuals, it can be challenging for donors to find and connect with them.",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: context.getDefaultSize(),
                  ),
                  const Text(
                    "The Aid App aims to provide a convenient and user-friendly platform for donors to connect with people in need of aid. Donors will be able to create an account and list the items they are willing to donate. The app will facilitate the donation process by allowing donors to make requests for donating their items.",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: context.getDefaultSize(),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
