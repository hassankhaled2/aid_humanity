import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class SigninWithGoogle extends StatelessWidget {
  const SigninWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey, width: context.getDefaultSize() * 0.3),
        borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
      ),
      width: context.getDefaultSize() * 32,
      height: context.getDefaultSize() * 4.7,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 1.5),
        child: Row(
          children: [
            Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: context.getDefaultSize() * 1,
            ),
            Text(
              'Continue with google',
              style: TextStyle(
                fontSize: context.getDefaultSize() * 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
