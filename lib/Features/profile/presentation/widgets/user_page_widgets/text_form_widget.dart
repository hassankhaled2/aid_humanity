import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

class TextFromWidget extends StatelessWidget {
  final int? maxLines;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  const TextFromWidget({super.key, this.labelText, this.prefixIcon, this.suffixIcon, this.obscureText, this.keyboardType, required this.controller, this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines:maxLines,
        controller: controller,
        obscureText: obscureText!, // for invisible Text as passwords
        keyboardType: keyboardType, 
        decoration: InputDecoration(
          iconColor: AppColorsLight.primaryColor,
          prefixIconColor: AppColorsLight.primaryColor,
          suffixIconColor: AppColorsLight.primaryColor,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsLight.primaryColor),
          ), //amazing shape for TFF
          prefixIcon: Icon(prefixIcon!),
          suffixIcon: obscureText! ? Icon(suffixIcon!) : null,
        ));
  }
}
