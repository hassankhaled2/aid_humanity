import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsLight.primaryColor,
        borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
      ),
      width: context.getDefaultSize() * 13,
      height: context.getDefaultSize() * 4,
      child: Center(
        child: Text(
          'Send',
          style: TextStyle(
            fontSize: context.getDefaultSize() * 1.7,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
