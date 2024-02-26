import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Passwordtextfield extends StatelessWidget {
  const Passwordtextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: context.getDefaultSize() * 1.7,
            horizontal: context.getDefaultSize() * 1),
        suffixIcon: const Icon(Icons.visibility),
        hintText: 'Password',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.getDefaultSize() * 1.3),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
    ;
  }
}
