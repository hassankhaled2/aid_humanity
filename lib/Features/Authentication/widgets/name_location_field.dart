//import 'dart:html';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NameLocationField extends StatelessWidget {
  NameLocationField({super.key, required this.name, required this.location});
  String name;
  String location;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getDefaultSize() * 20,
      height: context.getDefaultSize() * 7,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: context.getDefaultSize() * 2.3),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                location,
                style: TextStyle(fontSize: context.getDefaultSize() * 1.9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
