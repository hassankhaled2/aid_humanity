 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/entites/user_entity.dart';

abstract class LoginRemoteDataSource
 {

    Future<UserEntity>postUserData(String fullName,String email,String phone,String address);
    Future<UserEntity?>loginWithGoogle();
 }
 class LoginRemoteDataSourceImpl extends LoginRemoteDataSource
 {
/// handle exception
   CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');
  @override
  Future<UserEntity> postUserData(String fullName,String email,String phone,String address) async {
 await categories.add({
      "Full Name":fullName,
      "Email":email,
      "Phone":phone,
      "Address":address,
      // to determine which each user add to firestore that depend on  their ID
      "id":FirebaseAuth.instance.currentUser!.uid
    });
 throw UnimplementedError();

  }

  @override
  Future<UserEntity?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication?googleAuth  = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(

      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    throw UnimplementedError();
  }




  }



