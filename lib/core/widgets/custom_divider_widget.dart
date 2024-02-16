import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key, this.color = AppColorsLight.dividerColor, this.thickness = 2.0, this.whiteSpaceEnd = 0, this.whiteSpaceBegin = 0, this.height = 1});
  final double height;
  final Color color;
  final double thickness;
  final double whiteSpaceEnd;
  final double whiteSpaceBegin;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      indent: whiteSpaceBegin,
      endIndent: whiteSpaceEnd,
      height: height,
    );
  }
}
