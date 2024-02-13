import 'package:aid_humanity/Features/Authentication/widgets/custom_button.dart';
import 'package:aid_humanity/Features/Authentication/widgets/custom_divider.dart';
import 'package:aid_humanity/Features/Authentication/widgets/custom_text_field.dart';
import 'package:aid_humanity/Features/Authentication/widgets/password_text_field.dart';
import 'package:aid_humanity/Features/Authentication/widgets/signin_with_facebook.dart';
import 'package:aid_humanity/Features/Authentication/widgets/signin_with_google.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class SigninWidget extends StatelessWidget {
  const SigninWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.getDefaultSize() * 3,
            vertical: context.getDefaultSize() * 7),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: context.getDefaultSize() * 3.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Back!',
                    style: TextStyle(
                      fontSize: context.getDefaultSize() * 3.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.getDefaultSize() * 1.2,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        fontSize: context.getDefaultSize() * 2.2,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF8B145),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' to your account',
                          style: TextStyle(
                            fontSize: context.getDefaultSize() * 1.8,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.getDefaultSize() * 4,
              ),
              CustomTextField(
                hintText: 'Email or Phone number',
              ),
              SizedBox(
                height: context.getDefaultSize() * 2,
              ),
              const Passwordtextfield(),
              SizedBox(
                height: context.getDefaultSize() * 1.8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Reset password?',
                    style: TextStyle(
                      fontSize: context.getDefaultSize() * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.getDefaultSize() * 2.5,
              ),
              CustomButton(
                text: 'Sign in',
              ),
              SizedBox(
                height: context.getDefaultSize() * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(
                      fontSize: context.getDefaultSize() * 1.8,
                    ),
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: context.getDefaultSize() * 1.8,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF8B145),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.getDefaultSize() * 2,
              ),
              const CustomDivider(),
              SizedBox(
                height: context.getDefaultSize() * 4,
              ),
              const SigninWithGoogle(),
              SizedBox(
                height: context.getDefaultSize() * 1,
              ),
              const SigninWithFacebook(),
            ],
          ),
        ),
      ),
    );
  }
}
