import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication {

  // google SignIN
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // Sign In via email & password

 static SignUp () async {

 //    try {
 //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
 //       email: emailAddress,
 //       password: password,
 //     );
 //   } on FirebaseAuthException catch (e) {
 //     if (e.code == 'weak-password') {
 //       print('The password provided is too weak.');
 //     } else if (e.code == 'email-already-in-use') {
 //       print('The account already exists for that email.');
 //     }
 //   } catch (e) {
 //     print(e);
 //   }
 // }
 print('sss');
  }
}