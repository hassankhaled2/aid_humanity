import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddImageWidget extends StatelessWidget {
  AddImageWidget({super.key, required this.color, required this.icon});
  Color color;
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.getDefaultSize(),
          left: context.getDefaultSize(),
          right: context.getDefaultSize()),
      child: Container(
        height: context.getDefaultSize() * 18,
        width: context.getDefaultSize() * 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color)),
        child: Center(child: icon),
      ),
    );
  }
}
