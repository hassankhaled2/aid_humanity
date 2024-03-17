// ignore_for_file: must_be_immutable

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';

import 'package:flutter/material.dart';

class ChooseItemWidget extends StatelessWidget {
  ChooseItemWidget(
      {super.key,
      required this.path,
      required this.title,
      required this.season}) {}
  String path;
  String title;
  String season;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: context.getDefaultSize() * 20,
          width: context.getDefaultSize() * 20,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Colors.grey.withOpacity(.1),
              spreadRadius: 20,
              offset: const Offset(10, 10),
            ),
          ]),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getDefaultSize() * 2,
                  vertical: context.getDefaultSize() * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: context.getDefaultSize() * 2,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: context.getDefaultSize() * 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          height: context.getDefaultSize() * 11,
          width: context.getDefaultSize() * 24,
          top: -8,
          child: Image.asset(path),
        ),
      ],
    );
  }
}
