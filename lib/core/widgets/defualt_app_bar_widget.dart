import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

AppBar getDefaultAppBarWidget({required BuildContext context, required String title,required Color color,List<Widget>? actions})
{
  return AppBar(
    title: Text(title,),
    toolbarHeight: context.getDefaultSize() * 4.8, //  for increasing the height based on the screen size
    titleTextStyle: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2),
    actions:actions

  );
}
