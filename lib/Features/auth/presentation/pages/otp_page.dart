

import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpPage extends StatefulWidget {
  OtpPage({required this.verficaationid, required this.PhoneNumber});

  final String verficaationid;
  final String PhoneNumber;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // late final phoneNumber;
  TextEditingController otpcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
 String verification='';
  Widget  _buildintroText(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
      [
        Text('Verify your phone Number',style:TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
        SizedBox(height: 5,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 33),
          child: RichText(
              text: TextSpan(
                  text: 'Enter your 6 digit code number to sent to',
                  style: TextStyle(height: 1.2,fontSize: 18,color: Colors.black),
                  children:
                  [
                    WidgetSpan(child: SizedBox(width: 5,)),
                    TextSpan(text:widget.PhoneNumber,style: TextStyle(color: Colors.blue))
                  ]
              )),

        ),


      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold
      (
      backgroundColor: Colors.white,
      // package make form automatic
      body:Padding(
        padding: const EdgeInsets.only(left: 20,top: 100,right: 20,),
        child: ListView(

          children:
          [
            Column(
              children:
              [
                _buildintroText(context),
                SizedBox(height: 88,),
                Container(
          child: PinCodeTextField(
            controller:otpcontroller ,
            appContext: context,
            length: 6,
            keyboardType: TextInputType.number,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              activeColor: Colors.blue,
              // inactiveColor: Colors.blue,
              inactiveFillColor: Colors.white,
              // activeFillColor: Colors.blue,
              selectedColor: Colors.blue,
              selectedFillColor: Colors.white,
            ),
            animationDuration: Duration(milliseconds: 300),
            // backgroundColor: Colors.blue.shade50,
            enableActiveFill: true,
            cursorColor:Colors.black,

            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              // setState(() {
              //   currentText = value;
              // });

            },

          ),
        ),
                SizedBox(height: 88,),
                // _builtverifyButton(),
                 Center(
       child: Container(
      height: 35,
          width: 210,
          child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))),

        onPressed: ()

        async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verficaationid, smsCode:otpcontroller.text);
          await auth.signInWithCredential(credential);
 if (auth.currentUser?.uid!=null)
 {
   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNavigation()));
 }
        }, child:Text('Verify')),
    ),
    ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
