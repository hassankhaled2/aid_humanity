import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.text});

  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
      ),
      width: context.getDefaultSize() * 13,
      height: context.getDefaultSize() * 4,
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
            fontSize: context.getDefaultSize() * 1.7,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
