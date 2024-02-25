
import 'package:aid_humanity/Features/auth/presentation/pages/phone_number_page.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../../../core/utils/styles/styles.dart';
import '../../../../core/widgets/BottomNavigation.dart';
import '../widgets/text_form_field.dart';
import 'login_page.dart';




class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _State();
}

class _State extends State<RegisterPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState>formState=GlobalKey();
  bool isPassword=true;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigation(),));

    // addCateogry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: Padding(
        padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
        child: ListView(
          children:
          [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text('Sign Up',style: Styles.textStyle25,),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 40,),
                    child: CustomTextForm(
                      obscureText: false,


                      hinttext:"First Name" ,
                      mycontroller:firstName ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      },

                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CustomTextForm(
                      obscureText: false,
                      hinttext:"Last Name" ,
                      mycontroller:lastName ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      },

                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child:CustomTextForm(
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
                  Padding(
                    padding: EdgeInsets.only(top: 15,),
                    child: CustomTextForm(
                      obscureText: false,
                      hinttext:"Email" ,
                      mycontroller:email ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      },

                    ),

                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 15,),
                      child: CustomTextForm(
                        obscureText:isPassword,
                        suffix: isPassword?Icons.visibility:Icons.visibility_off,
                        suffixpressed:  ()
                        {
                          setState(() {
                            isPassword=!isPassword;
                          });
                        },
                        hinttext: "Password",
                        mycontroller: password,
                        validator: (val)
                        {
                          if(val=="")
                          {
                            return'can not to be empty';
                          }
                          return null;
                        },


                      )
                  ),
                  SizedBox(height: 50,),
                  Center(
                    child: Container(
                      height: 35,
                      width: 210,
                      child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))),

                          onPressed: ()

                          async {
    if(formState.currentState!.validate()) {
      try {
       final creditional= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
     await FirebaseAuth.instance.currentUser!.sendEmailVerification();
       Navigator.of(context).pushNamedAndRemoveUntil(bottomNavigation, (route) => false);
    // if(creditional.user!.emailVerified)
    // {
    // Navigator.of(context).pushReplacementNamed(bottomNavigation);
    // }else {
    //
    //   AwesomeDialog(
    //     context: context,
    //     dialogType: DialogType.error,
    //     animType: AnimType.rightSlide,
    //     title: 'Error',
    //     desc:
    //     'please go to your gmail and make verify to your email',
    //   ).show();
    // }
        // GoRouter.of(context).push(AppRouter.KBottomNavigation);

      } on FirebaseAuthException catch (e) {
         if (e.code ==e.code) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'try another email or password',
            buttonsTextStyle: const TextStyle(color: Colors.black),
            showCloseIcon: true,

          ).show();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
                          }, child:Text
                        ('Sign Up')),
                    ),
                  ),
                  SizedBox(height: 35,),
                  const Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider()
                        ),

                        Text("OR"),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                        signInWithGoogle();
                      }, icon:Icon(FontAwesomeIcons.google), label:Text('Continue with Google',style: TextStyle(color: Colors.white),),),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton.icon(

                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhoneNumberPage()));
                      }, icon:Icon(FontAwesomeIcons.phone), label:Text('Continue with  Phone',style: TextStyle(color: Colors.white),),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:
                    [
                      Text('Are you have account?'),
                      TextButton(onPressed: ()
                       {

                        //pushReplacementNamed --> علشان ميعملش back button
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>LoginPage(),

                        )
                        );
                        // GoRouter.of(context).push(AppRouter.KLoginScreen);
                        }, child:Text('Sign in',style: TextStyle(color: Colors.orange))),


                    ],
                  ),
                  // SizedBox(height: 10,),
                  // Center(
                  //   child: InkWell(
                  //     onTap: ()
                  //     {
                  //
                  //     },
                  //     child: Ink(
                  //       color: Color(0xFF397AF3),
                  //       child: Padding(
                  //         padding: EdgeInsets.all(6),
                  //         child: Wrap(
                  //           crossAxisAlignment: WrapCrossAlignment.center,
                  //           children: [
                  //             // Image.asset(AssetsData.googleLogo), // <-- Use 'Image.asset(...)' here
                  //             SizedBox(width: 12),
                  //             Text('Sign in with Google'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )




                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
