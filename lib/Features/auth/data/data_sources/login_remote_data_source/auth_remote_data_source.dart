 import 'package:aid_humanity/core/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../../../../core/error/exceptions.dart';
import '../../../domain/entites/user_entity.dart';
import '../../models/user_data_model.dart';

abstract class AuthRemoteDataSource
 {

    Future<UserDataModel>postUserData(String fullName,String email,String phone,String address);
    Future<UserDataModel>login();
 }
 class AuthRemoteDataSourceImpl extends AuthRemoteDataSource
 {
   /// should put this in another dart file
  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication?googleAuth  = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(

      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
   return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  @override
  Future<UserDataModel> login()async {
    UserCredential userCredential;

    try {
      userCredential = await loginWithGoogle();

    } catch (error) {
      throw ServerException(exceptionName: error.toString());
    }
    final UserDataModel userModel =UserDataModel(displayNameGoogle: userCredential.user!.displayName, email: userCredential.user!.email, photoUrl: userCredential.user!.photoURL,  userId: userCredential.user!.uid);
    return Future.value(userModel);
  }

  /// see it again
  CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');
  @override
  Future<UserDataModel> postUserData(String fullName,String email,String phone,String address) async {
    await categories.add({
      "Full Name":fullName,
      "Email":email,
      "Phone":phone,
      "Address":address,
      // to determine which each user add to firestore that depend on  their ID
      "id":FirebaseAuth.instance.currentUser!.uid
    });
return UserDataModel(displayNameGoogle:fullName , email: email, photoUrl: "", userId: "");
  }


  }



