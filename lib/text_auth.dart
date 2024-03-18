import 'package:flutter/material.dart';

class TestAuth extends StatefulWidget {
  const TestAuth({super.key,required this.display, required this.email, required this.photo});
  final String display;
  final String email ;
  final String photo;
  @override
  State<TestAuth> createState() => _TestAuthState();
}

class _TestAuthState extends State<TestAuth> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold
      (
      body: Column
        (
        children:
        [
          Text(widget.display),
          Text(widget.email),
          SizedBox(height:10 ,),
          Image.network(widget.photo),
        ],
      ),
    );
  }
}
