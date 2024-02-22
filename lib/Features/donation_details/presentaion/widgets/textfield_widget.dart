import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';

SizedBox textFieldDonationDetails(
    BuildContext context, String hintText, double width, double padding) {
  return SizedBox(
    width: context.getDefaultSize() * width,
    child: Padding(
      padding: EdgeInsets.only(left: context.getDefaultSize() * padding,bottom: context.getDefaultSize() * padding),
      child: TextField(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.getDefaultSize() * 2),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    ),
  );
}
