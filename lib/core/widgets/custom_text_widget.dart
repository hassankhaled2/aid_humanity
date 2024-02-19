import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  CustomTextWidget(
      {super.key,
      required this.fontsize,
      required this.color,
      required this.padding,
      required this.text});
  double fontsize;
  String text;
  double padding;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.getDefaultSize() * padding,
        bottom: context.getDefaultSize() * padding,
        left: context.getDefaultSize(),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: context.getDefaultSize() * fontsize,
            color: color,
            fontWeight: FontWeight.bold
            ),
      ),
    );
  }
}
