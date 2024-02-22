import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestGoogleMaps extends StatefulWidget {
  const TestGoogleMaps({super.key, required this.position});
  final Position position;

  @override
  State<TestGoogleMaps> createState() => _TestGoogleMapsState();
}

class _TestGoogleMapsState extends State<TestGoogleMaps> {
  @override
  void initState() {
    _handleLocationPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.from([
          Marker(
              markerId: const MarkerId("1"),
              position:
                  LatLng(widget.position.latitude, widget.position.latitude))
        ]),
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.position.latitude, widget.position.latitude)),
      ),
    );
  }
}

Future<bool> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
