import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/login.dart';
import 'package:findee/screens/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //change screen
  changeScreen(){
    Future.delayed(Duration(seconds: 2), () {
      //Get.to(() => SignInScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.offAll(() => MyLogin());
        } else {
          Get.offAll(() => Navigation());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/FindeeLogoFinal.png', width: 200, height: 200, fit: BoxFit.fitWidth),
      ),
    );
  }
}
