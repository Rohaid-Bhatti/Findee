import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isLoading = false.obs;

  //signin method
  Future<UserCredential?> loginMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
    return userCredential;
  }

  //storing data method
  storeUserData({name, password, email, phoneNumber}) async {
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name' : name,
      'password' : password,
      'email' : email,
      'image' : '',
      'phoneNumber' : phoneNumber,
      'uid' : currentUser!.uid,
    });
  }

  /*void addDataToFirestore({name, number, desc, image, phoneNumber, reward, category, longitude, latitude}) async {
    // Get a reference to the collection
    CollectionReference usersRef = firestore.collection(adsCollection);

    String newDocId = usersRef.doc().id;
    // Get the ID of the logged-in user
    String userId = auth.currentUser!.uid;

    // Get the email and username of the logged-in user from Firestore
    DocumentSnapshot userSnapshot = await firestore.collection('users').doc(userId).get();
    String email = userSnapshot.get('email');
    String username = userSnapshot.get('name');

    // Create a new document with a generated ID
    await usersRef.doc(newDocId).set({
      'name': name,
      'number': number,
      'desc': desc,
      'image': image ?? '',
      'reward': reward,
      'category': category,
      'longitude': longitude,
      'latitude': latitude,
      'id': newDocId, // Save the ID as a field in the document
      'userId': userId, // Save the ID of the logged-in user
      'email': email, // Save the email of the logged-in user
      'username': username, // Save the username of the logged-in user
    });
    Fluttertoast.showToast(msg: "Ads created");
  }*/

  //signout
  signoutMethod() async {
    try{
      await auth.signOut();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }
}