import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninWithFacebook extends StatelessWidget {
  const SigninWithFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
      ),
      width: context.getDefaultSize() * 32,
      height: context.getDefaultSize() * 4.7,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 2.2),
        child: Row(
          children: [
            Container(
              width: context.getDefaultSize() * 3,
              child: Image.asset(
                'assets/images/1692797523facebook-logo-png-white.webp',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: context.getDefaultSize() * 1.8,
            ),
            Text(
              'Continue with facebook',
              style: TextStyle(
                  fontSize: context.getDefaultSize() * 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
