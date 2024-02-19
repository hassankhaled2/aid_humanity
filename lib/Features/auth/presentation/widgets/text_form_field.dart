import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ;
  final TextEditingController mycontroller ;
  final String ?Function(String?)?validator;
   final IconData ?suffix;
   final  VoidCallback? suffixpressed;
     final  bool obscureText;
   CustomTextForm({super.key, required this.hinttext, required this.mycontroller,  this.validator, this.suffix, this.suffixpressed, required this.obscureText, });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText,
      onTapOutside: (event)=>FocusScope.of(context).unfocus(),
      validator: validator,
      controller: mycontroller,
      ///see it again
      decoration: InputDecoration(
        suffixIcon: suffix != null ? IconButton(
        onPressed: suffixpressed,
        icon: Icon(suffix),
      )
            : null,
        hintText: hinttext,
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color:Colors.black)
        ),
    //اول لما تدوس على ال textformfield
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color:Colors.orangeAccent)
    ),
      ),



    );
  }
}