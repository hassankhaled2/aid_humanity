

import 'package:aid_humanity/Features/auth/presentation/widgets/phone.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../widgets/text_form_field.dart';
import 'otp_page.dart';


class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({Key? key}) : super(key: key);


  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  TextEditingController phone = TextEditingController();
   // int
  final String b='EG';
  // TextEditingController c = TextEditingController();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  Widget _buildIntroText()
  {
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('What is your phone Number',
            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Text(
            'Please enter your phone number to verify your account',
            style: TextStyle(color: Colors.black,fontSize: 15),
          )

        ],
      ),
    );
  }

  // Widget _phoneFormField()
  // Widget _builtverifyButton(BuildContext context) {
  //   return      Center(
  //     child: Container(
  //       height: 35,
  //       width: 210,
  //       child: ElevatedButton(
  //           style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))),
  //
  //           onPressed: ()
  //           async {
  //
  //             phoneauth(context,);
  //
  //           }, child:Text('next')),
  //     ),
  //   );
  // }

  // String generateCountryFlag()
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: Form(
        key: _phoneFormKey,
        child: SafeArea(
          // key: _phoneFormKey,
          child: Column
            (
            children:
            [
              _buildIntroText(),
              SizedBox(height: 30,),
              Padding(
              padding: const EdgeInsets.all(10.0),
                child:CustomTextForm(
                  // prefixIcon: CountryCodePicker(
                  //   onChanged: (CountryCode countryCode)
                  //   {
                  //   },
                  //   initialSelection: 'EG',
                  //   showFlag: true,
                  //   favorite: const ['+20', 'EG'],
                  //    showCountryOnly: false,
                  //   showOnlyCountryWhenClosed: false,
                  //     alignLeft: false,
                  //    showDropDownButton: true,
                  //   padding: EdgeInsets.zero,
                  //  ),
                  keyboardType: TextInputType.phone,
                  // inputFormatters:
                  // [
                  //   FilteringTextInputFormatter.allow(RegExp(r'^\-?(\d+\.?\d{0,2})?')),
                  // ],
                  obscureText: false,
                  hinttext:"+20XXXXXXXXXX" ,
                  mycontroller:phone ,
                  validator: (val)
                  {
                    if(val=="")
                    {
                      return'can not to be empty';
                    }
                    return null;
                  },

                ),
//             child: IntlPhoneField(
//               autofocus: true,
//               focusNode:FocusNode(),
//               // searchText:b ,
//               // initialCountryCode: b,
//                initialCountryCode: "IN",
//                 controller:phone ,
// onCountryChanged: (value)
// {
//   print("hhhhhhhhhhhhhhhhhhhhhh""${value.code}");
// },
//  onChanged: (value)
//  {
//
//    print("Countryhghghghghghghghghghghghg""${value.countryCode}");
//  },
//               decoration: InputDecoration(
//
//                 hintText: 'Phone Number',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(),
//                 ),
//               ),
//             ),
            ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              height: 35,
              width: 210,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))),

                  onPressed: ()
                  async {



 if(_phoneFormKey.currentState!.validate()){
   await name(context,phone.text);
 }
                  }, child:Text('Next')),
            ),
          ),
            ],

          ),
        ),
      ),
    );
  }

  Future<void> name(BuildContext context,String PhoneNumber) async {
        await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:PhoneNumber,
      // phoneNumber:phone.text,
      //  phoneNumber:"+201129405068",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e)
      {
        // await auth.signInWithCredential(credential);

      },
      codeSent: (String verificationId, int? resendToken)
      async{
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpPage(verficaationid:verificationId,PhoneNumber: PhoneNumber,)));// Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        //
        // // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}



