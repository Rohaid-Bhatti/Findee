import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/constants.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  String name;
  String desc;
  var image;
  String number;
  String reward;
  String category;

  LocationScreen(
      {Key? key,
      required this.name,
      required this.desc,
      required this.image,
      required this.number,
      required this.reward,
      required this.category})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var controller = Get.put(AuthController());
  GoogleMapController? _mapController;
  Position? _currentPosition;

  LatLng? currentLocation; // Variable to store the current location

  void addDataToFirestore() async {
    // Get a reference to the collection
    CollectionReference usersRef = firestore.collection(adsCollection);

    String newDocId = usersRef.doc().id;
    // Get the ID of the logged-in user
    String userId = auth.currentUser!.uid;

    // Get the email and username of the logged-in user from Firestore
    DocumentSnapshot userSnapshot = await firestore.collection('users').doc(userId).get();
    String email = userSnapshot.get('email');
    String username = userSnapshot.get('name');

    if (widget.image != null) {
      // Upload image to Firebase Storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('$newDocId.jpg');

      await ref.putFile(File(widget.image));

      // Get the download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();

      // Create a new document with a generated ID
      await usersRef.doc(newDocId).set({
        'name': widget.name,
        'number': widget.number,
        'desc': widget.desc,
        'image': imageUrl,
        'reward': widget.reward,
        'category': widget.category,
        'longitude': currentLocation?.latitude.toString(),
        'latitude': currentLocation?.longitude.toString(),
        'id': newDocId, // Save the ID as a field in the document
        'userId': userId, // Save the ID of the logged-in user
        'email': email, // Save the email of the logged-in user
        'username': username, // Save the username of the logged-in user
      });

      Fluttertoast.showToast(msg: "Ads created");
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show an error dialog or ask the user to enable it.
      return;
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    if (permission == LocationPermission.denied) {
      // Permissions are denied, ask for permission.
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permissions are denied, handle appropriately.
        return;
      }
    }

    // Get the current position
    Position currentPosition = await Geolocator.getCurrentPosition();
    if (!mounted) return;

    setState(() {
      _currentPosition = currentPosition;
      //again for the location saving
      currentLocation =
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Expanded(
              child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                    primary:  Colors.white,
                    backgroundColor: kActiveIconColor,
                    fixedSize: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.06),
                    ),
                child: Text("Post"),
                onPressed: () {
                 addDataToFirestore();
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        onClosing: () {},
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Center the map at (0, 0) initially
          zoom: 16.0,
        ),
        myLocationEnabled: true,
        compassEnabled: true,
        markers: (_currentPosition != null)
            ? {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  infoWindow: InfoWindow(
                    title: "Current Location",
                  ),
                ),
              }
            : {},
      ),
    );
  }
}
