// ignore_for_file: use_build_context_synchronously

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/utils/app_router/app_router.dart';
import '../../../../core/utils/styles/styles.dart';
import '../widgets/text_form_field.dart';
import 'extra_data_google.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isPassword = true;
  bool isLoading = false;

  Future signInWithGoogle(BuildContext context) async {
    // final user=FirebaseAuth.instance.currentUser;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final id = userCredential.user!.uid;
    final user = userCredential.user!;
    final displayName = user.displayName ?? 'hahadhda';
    final email = user.email ?? 'hdahdhah';
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return ExtaDataGoogle(displayName: displayName, Email: email, id: id);
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: context.getDefaultSize() * 14,
          left: context.getDefaultSize() * 2,
          right: context.getDefaultSize() * 2,
        ),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.translate("Welcome"),
                    style: Styles.textStyle25,
                  ),
                  Text(context.translate('Back!'), style: Styles.textStyle25),
                  SizedBox(
                    height: context.getDefaultSize() / 2,
                  ),
                  Row(
                    children: [
                      Text(
                        context.translate('Sign in '),
                        style:
                            Styles.textStyle17.copyWith(color: Colors.orange),
                      ),
                      Text(context.translate('to your account'),
                          style: TextStyle(
                              fontSize: context.getDefaultSize() * 1.6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.getDefaultSize() * 6,
                    ),
                    child: CustomTextForm(
                      obscureText: false,
                      hinttext: context.translate("Email"),
                      mycontroller: email,
                      validator: (val) {
                        if (val == "") {
                          return context.translate('can not to be empty');
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                      padding:
                          EdgeInsets.only(top: context.getDefaultSize() * 1.5),
                      child: CustomTextForm(
                        obscureText: isPassword,
                        suffix: isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixpressed: () {
                          setState(() {
                            //if available make it not & vice versa
                            isPassword = !isPassword;
                          });
                        },
                        hinttext:context.translate( "Password"),
                        mycontroller: password,
                        validator: (val) {
                          if (val == "") {
                            return context.translate('can not to be empty');
                          }
                          return null;
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        left: context.getDefaultSize() * 20,
                        top: context.getDefaultSize()),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () async {
                              if (email.text == '') {
                                AwesomeDialog(
                                  context: context,
                                  showCloseIcon: true,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: context.translate('Error'),
                                  desc:
                                      context.translate('please enter your email after that enter forget password'),
                                ).show();
                                return;
                              }
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email.text);
                                AwesomeDialog(
                                  context: context,
                                  showCloseIcon: true,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: context.translate('Error'),
                                  desc:
                                      context.translate('please go to your gmail and make verify to your email'),
                                ).show();
                              } catch (e) {
                                AwesomeDialog(
                                  context: context,
                                  showCloseIcon: true,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: context.translate('Error'),
                                  desc:
                                      context.translate('there is something wrong in your account'),
                                ).show();
                                //  print(e);
                              }
                            },
                            child:Text(
                              context.translate('Forget Password?'),
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.getDefaultSize() * 3,
                  ),
                  Center(
                    child: Container(
                      height: context.getDefaultSize() * 4.3,
                      width: context.getDefaultSize() * 24,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.black),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          context.getDefaultSize() * 2)))),
                          onPressed: () async {
                            if (formState.currentState!.validate()) {
                              try {
                                isLoading = true;
                                setState(() {});
                                final creditional = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                if (creditional.user!.emailVerified) {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppRouter.circleAvatarProfile);
                                } else {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                  AwesomeDialog(
                                    context: context,
                                    showCloseIcon: true,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.rightSlide,
                                    title: context.translate('Error'),
                                    desc:
                                        context.translate('please go to your gmail and make verify to your email'),
                                  ).show();
                                }
                                isLoading = false;
                                setState(() {});
                              } on FirebaseAuthException catch (e) {
                                isLoading = false;
                                setState(() {});

                                ///Error in this line code
                                if (e.code == e.code) {
                                  print(
                                      context.translate('there is a something wrong in password or email.'));
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: context.translate('Error'),
                                    desc:
                                        context.translate('there is a something wrong in password or email.'),
                                    buttonsTextStyle:
                                        const TextStyle(color: Colors.black),
                                    showCloseIcon: true,
                                  ).show();
                                } else {
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>BottomNavigation()));
                                }
                              }
                            }
                          },
                          child:  Text(
                            context.translate('Sign In'),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: context.getDefaultSize() * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(context.translate('Don\'t have account ?')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                          },
                          child:  Text(
                            context.translate('Sign up'),
                            style: TextStyle(color: Colors.orange),
                          ))
                    ],
                  ),
                 Row(children: <Widget>[
                    Expanded(child: Divider()),
                    Text(context.translate("OR")),
                    Expanded(child: Divider()),
                  ]),
                  SizedBox(
                    height: context.getDefaultSize() * 4,
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: () async {
                        signInWithGoogle(context);
                        // await AuthRemoteDataSourceImpl().login();

                        //  await  AuthRepoImpl(
                        //      authRemoteDataSource:AuthRemoteDataSourceImpl(), networkInfo: ConnectionInfoImpl(internetConnectionChecker: InternetConnectionChecker())).authRemoteDataSource.login();
                        //  await UserDataModel(displayNameGoogle: displayNameGoogle, email: email, photoUrl: photoUrl, idToken: idToken, accessToken: accessToken, userId: userId);
                        //  Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.circleAvatarProfile, (route) => false);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      label: Text(
                        context.translate('Continue with Google'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  ///todo
                  // BlocListener<AuthLoginCubit, AuthLoginState>(
                  //   listener: (context, state) {
                  //     if(state is AuthLoginSuccess)
                  //     {
                  //       Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.circleAvatarProfile, (route) => false);
                  //     }
                  //
                  //   },
                  //   child: BlocBuilder<AuthLoginCubit, AuthLoginState>(
                  //     builder: (context, state) {
                  //       if (state is AuthLoginLoading) {
                  //         return Center(child: CircularProgressIndicator(
                  //           color: Colors.black,));
                  //       } else if (state is AuthLoginFailure) {
                  //         return Text(state.errorMessage);
                  //       } else {
                  //         return Center(
                  //           child: ElevatedButton.icon(
                  //             style: ButtonStyle(
                  //                 backgroundColor: MaterialStatePropertyAll(
                  //                     Colors.black)),
                  //             onPressed: () {
                  //               BlocProvider.of<AuthLoginCubit>(context).fetchAuthData();
                  //               // await CallLoginWithGoogleUseCase(AuthRepoImpl(authRemoteDataSource:AuthRemoteDataSourceImpl(), networkInfo: ConnectionInfoImpl(internetConnectionChecker: InternetConnectionChecker())));
                  //
                  //             },
                  //
                  //             icon: Icon(
                  //               FontAwesomeIcons.google, color: Colors.white,),
                  //             label: Text('Continue with Google',
                  //               style: TextStyle(color: Colors.white),),),
                  //         );
                  //
                  //         // return Center(
                  //         //   child: ElevatedButton.icon(
                  //         //     style: ButtonStyle(
                  //         //         backgroundColor: MaterialStatePropertyAll(
                  //         //             Colors.black)),
                  //         //     onPressed: () async{
                  //         //       await AuthLoginCubit(CallLoginWithGoogleUseCase(getIt.get<AuthRepoImpl>())).fetchAuthData();
                  //         //       Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.onBoarding, (route) => false);
                  //         //     },
                  //         //
                  //         //     icon: Icon(FontAwesomeIcons.google, color: Colors.white,),
                  //         //     label: Text('Continue with Google',
                  //         //       style: TextStyle(color: Colors.white),),),
                  //         // );
                  //       }
                  //     },
                  //   ),
                  // ),
                  // SizedBox(height: 10,),
                  // Center(
                  //   child: ElevatedButton.icon(
                  //
                  //     style: ButtonStyle(
                  //         backgroundColor: MaterialStatePropertyAll(
                  //             Colors.black)),
                  //     onPressed: () {
                  //       Navigator.of(context).push(MaterialPageRoute(builder: (
                  //           context) => PhoneNumberPage()));
                  //     },
                  //     icon: Icon(FontAwesomeIcons.phone, color: Colors.white,),
                  //     label: Text('Continue with  Phone',
                  //       style: TextStyle(color: Colors.white),),),
                  // )
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
