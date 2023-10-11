import 'package:findee/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationScreen extends StatefulWidget {
  final String latitude;
  final String longitude;

  const GetLocationScreen(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<GetLocationScreen> createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {

  @override
  Widget build(BuildContext context) {
    double latitudeDouble = double.parse(widget.latitude);
    double longitudeDouble = double.parse(widget.longitude);
    final LatLng _center = LatLng(longitudeDouble, latitudeDouble);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kActiveIconColor,
        title: Text(
          "Location",
          textAlign: TextAlign.center,
        ),
      ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 14.0,
          ),
          markers: {Marker(markerId: MarkerId('marker_1'), position: _center)},
        ),
    );
  }
}
