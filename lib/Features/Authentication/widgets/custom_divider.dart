import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomDividerWidget(
              whiteSpaceBegin: context.getDefaultSize() * 3.5,
              whiteSpaceEnd: context.getDefaultSize() * 2,
            )),
        const Text("OR"),
        Expanded(
            child: CustomDividerWidget(
              whiteSpaceEnd: context.getDefaultSize() * 3.5,
              whiteSpaceBegin: context.getDefaultSize() * 2,
            )),
      ],
    );
  }
}
