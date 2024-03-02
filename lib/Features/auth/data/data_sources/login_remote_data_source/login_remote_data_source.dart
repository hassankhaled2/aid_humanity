// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../../../../../core/utils/app_router/app_router.dart';
//
// abstract class LoginRemoteDataSource
// {
//  Future signInWithGoogle(BuildContext context);
//
// }
// class LoginRemoteDataImple extends LoginRemoteDataSource
// {
//   Future signInWithGoogle(BuildContext context) async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     Navigator.of(context).pushNamedAndRemoveUntil(Onboarding, (route) => false);
//
//     // addCateogry();
//   }
// }