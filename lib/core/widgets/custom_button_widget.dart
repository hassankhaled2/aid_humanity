import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.fontSize,
  });
  double height;
  double width;
  String title;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getDefaultSize() * height,
      width: context.getDefaultSize() * width,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(
          context.getDefaultSize() * 2,
        ),
      ),
      child: Center(
        child: CustomTextWidget(
            padding: 1, fontsize: fontSize, text: title, color: Colors.white),
      ),
    );
  }
}
