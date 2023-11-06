import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

AppBar getDefultAppBarWidget({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(title),
    toolbarHeight: context.getDefaultSize() * 4.8, //  for increasing the height based on the screen size
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2),
  );
}
