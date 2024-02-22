import 'package:aid_humanity/Features/home/presentation/widgets/view_details_widget.dart';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';

import 'package:aid_humanity/core/widgets/default_elevated_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CardWidget extends StatefulWidget {
  CardWidget({Key? key}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;
  getData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("request")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: context.getDefaultSize() * 3.4,
              right: context.getDefaultSize() * 3.4,
              bottom: context.getDefaultSize() * 1.4),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: context.getDefaultSize() * 40,
                  child: Image(
                    height: context.getDefaultSize() * 13,
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        "https://www.thfashions.org/wp-content/uploads/2022/07/GettyImages-1342605876-640x372.jpg"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: context.getDefaultSize() * .9,
                      top: context.getDefaultSize() * .8),
                  child: Text(
                    "Person's name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.getDefaultSize() * 2.1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: context.getDefaultSize() * .9,
                        bottom: context.getDefaultSize() * .6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(""),
                            SizedBox(
                              width: context.getDefaultSize() * 22,
                            ),
                            Text(
                              "20 min ago",
                              style: TextStyle(
                                  color: Colors.orange,
                                  height: context.getDefaultSize() * .23,
                                  fontSize: context.getDefaultSize() * 1.5),
                            ),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: context.getDefaultSize() * 2,
                      bottom: context.getDefaultSize() * 1),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowUpRightFromSquare,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: context.getDefaultSize() * 1,
                      ),
                      Text(
                        "8 km",
                        style: TextStyle(
                            fontSize: context.getDefaultSize() * 1.7,
                            color: Colors.grey[600]),
                      ),
                      SizedBox(
                        width: context.getDefaultSize() * 11,
                      ),
                      DefaultElevatedButton(
                        onPressed: () async {
                          Position position = await _determinePosition();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (ViewDetailsWidget(
                                      position: position,
                                    ))),
                          );
                        },
                        text: "View Details",
                        radius: 10,
                        height: context.getDefaultSize() * 2.85,
                        width: context.getDefaultSize() * 14.2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position position = await Geolocator.getCurrentPosition();

  List<Placemark> placemarks =
      await placemarkFromCoordinates(position!.latitude, position!.longitude);
  print(placemarks[0].street);
  print(placemarks[0].locality);
  return position;
}
