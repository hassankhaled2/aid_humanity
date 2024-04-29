import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:aid_humanity/cubit/dlivery_location_cubit.dart';
import 'package:aid_humanity/injection_container.dart';

class OrderDelivery extends StatefulWidget {
  final LatLng donorLatLng;
  final String reqId;

  const OrderDelivery({Key? key, required this.donorLatLng, required this.reqId}) : super(key: key);

  @override
  State<OrderDelivery> createState() => _OrderDeliveryState();
}

class _OrderDeliveryState extends State<OrderDelivery> {
  GoogleMapController? googleMapController;
  StreamSubscription? donarDelivSubscription;
  double? deliveryLat;
  double? deliveryLng;
  Marker? marker;
  Circle? circle;
  String? deliveryId;

  @override
  void initState() {
    FirebaseFirestore.instance.collection('request').doc(widget.reqId).get().then((value) {
      deliveryId = value.data()!['deliveryId'];
    });
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/pics/cycle_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarker(Position position, Uint8List imageData) async {
    LatLng latLng = LatLng(position.latitude, position.longitude);
    setState(() {
      marker = Marker(
        markerId: const MarkerId("Delivery Location"),
        position: latLng,
        draggable: false,
        zIndex: 2,
        icon: BitmapDescriptor.fromBytes(imageData),
        infoWindow: const InfoWindow(title: "Delivery Location"),
        flat: true,
        anchor: const Offset(0.5, 0.5),
      );
      circle = Circle(
        circleId: const CircleId("Delivery Location"),
        center: latLng,
        radius: 100,
        zIndex: 1,
        fillColor: Colors.blue.withAlpha(70),
        strokeColor: Colors.blue,
        strokeWidth: 5,
      );
    });
  }

  void getCurrentLocation() async {
    Uint8List imageData = await getMarker();
    donarDelivSubscription = getIt<FirebaseFirestore>().collection('UsersAuth').doc(deliveryId).snapshots().listen((event) {
      Position position = Position(latitude: event.data()!['LAT'], longitude: event.data()!['LNG'], timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 0, headingAccuracy: 0);
      print("updateeeeeeedddddddddddd");
      if (event.data() != null) {
        if (googleMapController != null) {
          setState(() {
            googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18, tilt: 0)));
            updateMarker(position, imageData);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deliveryLocationCubit = BlocProvider.of<DliveryLocationCubit>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getCurrentLocation();
          },
          child: const Icon(Icons.location_on)),
      body: BlocBuilder<DliveryLocationCubit, DliveryLocationState>(
        builder: (context, state) {
          if (state is GetLocationSuccessState) {
            return GoogleMap(
                circles: Set.of((circle != null) ? [circle!] : []),
                markers: Set.of((marker != null)
                    ? [
                        marker!,
                        Marker(
                            markerId: const MarkerId("1"),
                            position: widget.donorLatLng,
                            infoWindow: const InfoWindow(
                              title: "Donor Location",
                            ))
                      ]
                    : []),
                mapType: MapType.hybrid,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                },
                initialCameraPosition: CameraPosition(zoom: 14.46, target: LatLng(deliveryLocationCubit.position.latitude, deliveryLocationCubit.position.longitude)));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
