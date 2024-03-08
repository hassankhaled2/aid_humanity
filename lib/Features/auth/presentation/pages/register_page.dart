import 'package:aid_humanity/Features/auth/presentation/pages/phone_number_page.dart';
import 'package:aid_humanity/Features/onBoarding/onboarding.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/utils/styles/styles.dart';
import '../widgets/text_form_field.dart';
import 'login_page.dart';




class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _State();
}

class _State extends State<RegisterPage> {
  TextEditingController fullName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState>formState=GlobalKey();
  bool isloading =true;
  bool isPassword =true;
  CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');

  // addUsersData() async{
  //   if(formState.currentState!.validate()) {
  //     try {
  //       isloading=true;
  //       setState(() {
  //
  //       });
  //       //???
  //
  //       // Navigator.of(context).pushReplacementNamed('homepage');
  //       // // if process done right , print for me (.....)
  //       // .then((value) => print("User Added"))
  //       // //not run right, print for me (.....)
  //       // .catchError((error) => print("Failed to add user: $error"));
  //     }catch(e)
  //     {
  //       isloading=false;
  //       setState(() {
  //
  //       });
  //       print('Error $e');
  //     }
  //   }
  //   // Call the user's CollectionReference to add a new user
  //
  // }
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OnBoarding(),));

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
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Sign Up',style: Styles.textStyle25,),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 40,),
                    child: CustomTextForm(
                      obscureText: false,


                      hinttext:"Full Name" ,
                      mycontroller:fullName ,
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
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly

                      // prefixIcon: CountryCodePicker(
                      //   onChanged: (CountryCode countryCode) {},
                      //   initialSelection: 'EG',
                      //   showFlag: true,
                      //   favorite: const ['+20', 'EG'],
                      //   showCountryOnly: false,
                      //   showOnlyCountryWhenClosed: false,
                      //   alignLeft: false,
                      //   showDropDownButton: true,
                      //   padding: EdgeInsets.zero,
                      // ),                      // inputFormatters:
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
                    padding: EdgeInsets.only(top: 15),
                    child: CustomTextForm(
                      maxLines: 4,
                      obscureText: false,
                      hinttext:"Enter your Address" ,
                      mycontroller:address ,
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
                      padding: const EdgeInsets.only(top: 15,),
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
                  const SizedBox(height: 50,),
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
       DocumentReference add=await categories.add({
         "Full Name":fullName.text,
         "Email":email.text,
         "Phone":phone.text,
         "Address":address.text,
         // to determine which each user add to firestore that depend on  their ID
         "id":FirebaseAuth.instance.currentUser!.uid
       });
       // addUsersData();
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
       Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
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
                  const SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                        signInWithGoogle();
                      }, icon:Icon(FontAwesomeIcons.google), label:Text('Continue with Google',style: TextStyle(color: Colors.white),),),
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: ElevatedButton.icon(

                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhoneNumberPage()));
                      }, icon:Icon(FontAwesomeIcons.phone), label:Text('Continue with  Phone',style: TextStyle(color: Colors.white),),),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:
                    [
                      const Text('Are you have account?'),
                      TextButton(onPressed: ()
                       {

                        //pushReplacementNamed --> علشان ميعملش back button
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>LoginPage(),

                        )
                        );
                        }, child:Text('Sign in',style: TextStyle(color: Colors.orange))),


                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
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
