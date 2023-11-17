import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {

  final double ?width;
  final double ?height;
  final VoidCallback onPressed;
  final String text;
   final double  radius;


  const DefaultElevatedButton({Key? key,this.width,this.height, required this.onPressed, required this.text, required this.radius, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height??context.getDefaultSize() * 3.0,
        width: width,
        child: ElevatedButton(
          style:ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius),),),
          onPressed: onPressed,
          child: Text(text,style: TextStyle(
            fontSize: context.getDefaultSize() * 1.78,
          )),


        ));
  }
}


