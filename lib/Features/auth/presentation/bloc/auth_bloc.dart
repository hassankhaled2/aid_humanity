import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  SignUpBloc(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        super(SignUpInitial());

  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();
      try {
        final userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        final userId = userCredential.user?.uid;

        if (userId != null) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("userId", userId);

          DocumentReference docRef =
              await _firestore.collection('categories').add({
            "fullName": event.fullName,
            "Email": event.email,
            "Phone": event.phone,
            "street": event.street,
            "city": event.city,
            "region": event.region,
            "country": event.country,
            "flatNumber": event.flatNumber,
            "floorNumber": event.floorNumber,
            "LAT": event.latitude,
            "LNG": event.longitude,
            "id": userId,
          });

          sharedPreferences.setString("doc", docRef.id);

          await userCredential.user?.sendEmailVerification();

          yield SignUpSuccess();
        } else {
          yield SignUpFailure(error: "User ID is null");
        }
      } catch (e) {
        yield SignUpFailure(error: e.toString());
      }
    }
  }
}
