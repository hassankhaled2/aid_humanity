import 'dart:async';

import 'package:aid_humanity/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'dlivery_location_state.dart';

class DliveryLocationCubit extends Cubit<DliveryLocationState> {
  late Position position;
  late List<Placemark> userPlaceMark;
  StreamSubscription<dynamic>? deliverylocationSubscription;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  DliveryLocationCubit() : super(DliveryLocationInitial());

  updateUserLocation() async {
    userPlaceMark = await placemarkFromCoordinates(position.latitude, position.longitude);
  }

  void getCurrentLocation(BuildContext context) async {
    getLocation(context);
    deliverylocationSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      print("******************************************************************");
      getIt<FirebaseFirestore>().collection('UsersAuth').doc(FirebaseAuth.instance.currentUser!.uid).update({"LAT": position.latitude, "LNG": position.longitude});
    });
  }

  Future<void> getLocation(BuildContext context) async {
    emit(GetLocationLoadingState());
    try {
      await _handleLocationPermission(context);
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      userPlaceMark = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'en');

      emit(GetLocationSuccessState());
    } on Exception {
      emit(GetLocationFailedState());
    }
  }
}

Future<bool> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
