import 'package:aid_humanity/Features/Authentication/widgets/custom_button.dart';
import 'package:aid_humanity/Features/Authentication/widgets/custom_divider.dart';
import 'package:aid_humanity/Features/Authentication/widgets/custom_text_field.dart';
import 'package:aid_humanity/Features/Authentication/widgets/password_text_field.dart';
import 'package:aid_humanity/Features/Authentication/widgets/signin_with_facebook.dart';
import 'package:aid_humanity/Features/Authentication/widgets/signin_with_google.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
//import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getDefaultSize() * 3,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: context.getDefaultSize() * 7,
                ),
                Row(
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: context.getDefaultSize() * 3,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: context.getDefaultSize() * 3,
                ),
                CustomTextField(
                  hintText: 'Full Name',
                ),
                SizedBox(
                  height: context.getDefaultSize() * 1.8,
                ),
                CustomTextField(
                  hintText: 'Phone No',
                ),
                SizedBox(
                  height: context.getDefaultSize() * 1.8,
                ),
                CustomTextField(
                  hintText: 'Email',
                ),
                SizedBox(
                  height: context.getDefaultSize() * 1.8,
                ),
                const Passwordtextfield(),
                SizedBox(
                  height: context.getDefaultSize() * 3.5,
                ),
                CustomButton(
                  text: 'Submit',
                ),
                SizedBox(
                  height: context.getDefaultSize() * 3.5,
                ),
                const CustomDivider(),
                SizedBox(
                  height: context.getDefaultSize() * 3.5,
                ),
                const SigninWithGoogle(),
                SizedBox(
                  height: context.getDefaultSize(),
                ),
                const SigninWithFacebook(),
                SizedBox(
                  height: context.getDefaultSize() * 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(
                        fontSize: context.getDefaultSize() * 1.8,
                      ),
                    ),
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: context.getDefaultSize() * 1.8,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF8B145),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
