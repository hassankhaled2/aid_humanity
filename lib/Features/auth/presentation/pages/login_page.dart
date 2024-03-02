
import 'package:aid_humanity/Features/auth/presentation/pages/phone_number_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/utils/app_router/app_router.dart';
import '../../../../core/utils/styles/styles.dart';
import '../widgets/text_form_field.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState>formState=GlobalKey();
  bool isPassword=true;
  bool isloading=false;

  Future signInWithGoogle() async {
    // UserCredential userCredential;
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
    Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.onBoarding, (route) => false);

    // addCateogry();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: Padding(
        padding: const EdgeInsets.only(top: 120,left: 20,right: 20),
        child: ListView(
          children:
          [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text('Welcome',style: Styles.textStyle25,),
                  Text('Back!',style:Styles.textStyle25),
                  SizedBox(height: 10,),
                  Row(
                    children:
                    [
                      Text('Sign in ',style:Styles.textStyle17.copyWith(color: Colors.orange) ,),
                      Text('to your account',style: TextStyle(fontSize:15))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 40,),
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
                      padding: EdgeInsets.only(top: 15),
                      child: CustomTextForm(
                        obscureText:isPassword,
                        suffix: isPassword?Icons.visibility:Icons.visibility_off,
                        suffixpressed:  ()
                        {
                          setState(() {
                            //if available make it not & vice versa
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
                  Padding(
                    padding: const EdgeInsets.only(left:195,top: 10),
                    child: Row(children:
                    [
                      TextButton(onPressed: ()
                      async {
                        if(email.text=='')
                        {
                          AwesomeDialog(
                            context: context,
                            showCloseIcon: true,
                            dialogType:DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc:
                            'please enter your email after that enter forget password',
                          ).show();
                          return;
                        }
                        try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            showCloseIcon: true,
                            dialogType:DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc:
                            'please go to your gmail and make verify to your email',
                          ).show();
                        }catch(e)
                        {
                          AwesomeDialog(
                            context: context,
                            showCloseIcon: true,
                            dialogType:DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc:
                            'there is something wrong in your account',
                          ).show();
                        //  print(e);
                        }

                      }, child:Text('Forget Passsword?',style:TextStyle(color: Colors.black),))
                    ],),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Container(
                      height: 35,
                      width: 210,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))),
                          onPressed: ()
                          async {

                            if(formState.currentState!.validate())
                            {
                              try {
                                isloading=true;
                                setState((){});
                         final  creditional=  await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: email.text,
                                    password: password.text
                                );
                              if(creditional.user!.emailVerified)
                              {
                                Navigator.of(context).pushReplacementNamed(AppRouter.onBoarding);
                              }else
                              {
                                FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                AwesomeDialog(
                                  context: context,
                                  showCloseIcon: true,
                                  dialogType:DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Error',
                                  desc:
                                  'please go to your gmail and make verify to your email',
                                ).show();

                              }
                                isloading=false;
                                setState((){});


                              } on FirebaseAuthException catch (e) {
                                isloading=false;
                                setState(() {

                                });

                                ///Error in this line code
                                if (e.code == e.code) {
                                  print('there is a something wrong in password or email.');
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: 'there is a something wrong in password or email.',
                                    buttonsTextStyle: const TextStyle(color: Colors.black),
                                    showCloseIcon: true,

                                  ).show();
                                 }else
                                 {
                                   // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BottomNavigation()));
                                 }
                              }
                            }



                          }, child:Text
                        ('Sign In',style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                   SizedBox(height: 30,),
                  Row(
                   mainAxisAlignment:MainAxisAlignment.center,
                    children:
                    [
                      Text('Don\'t have account ?'),
                      TextButton(onPressed: ()
                      {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RegisterPage(),));
                      }, child:Text('Sign up',style: TextStyle(color: Colors.orange),))

                    ],
                  ),
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
                    }, icon:Icon(FontAwesomeIcons.google,color:Colors.white,), label:Text('Continue with Google',style: TextStyle(color: Colors.white),),),
                  ),
                   SizedBox(height: 10,),
                  Center(
                    child: ElevatedButton.icon(

                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhoneNumberPage()));
                      }, icon:Icon(FontAwesomeIcons.phone,color:Colors.white,), label:Text('Continue with  Phone',style: TextStyle(color: Colors.white),),),
                  )
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
