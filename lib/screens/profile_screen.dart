import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/CreateAd.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/constants.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:findee/categoryPage.dart';
import 'package:findee/login.dart';
import 'package:findee/screens/contact_screen.dart';
import 'package:findee/screens/edit_profile_screen.dart';
import 'package:findee/screens/help_center_screen.dart';
import 'package:findee/screens/my_ads.dart';
import 'package:findee/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final bool fromProfile;

  const ProfileScreen({Key? key, required this.fromProfile}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveIconColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.5,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Profile",
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>  snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              valueColor : AlwaysStoppedAnimation(Colors.black),
            );
          } else {
            final  data = snapshot.data!.docs[0];

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: data['image'] == ''
                        ? CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    )
                        : CircleAvatar(
                      backgroundImage: NetworkImage(data['image']),
                    ),/*CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),*/
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("${data['name']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("${data['email']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    leading: Icon(Icons.person, size: 20),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    title: Text("My Profile"),
                    trailing: Icon(Icons.edit, size: 16),
                    onTap: () {
                      /*Get.to(() => MyProfileScreen(
                      data: data,
                    ));*/
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditProfilePage(data: data,)));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.ads_click, size: 20),
                    title: Text("My Ads", style: TextStyle()),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyAds(userId: user!.uid)));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.add_sharp, size: 20),
                    title: Text("Create Ads", style: TextStyle()),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CreateAd()));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.mail, size: 20),
                    title: Text("Contact Us"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.question_mark, size: 20),
                    title: Text("Help Center"),
                    onTap: () {
                      //HelpCenterPage
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterPage()));
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(Icons.logout, size: 20),
                    title: Text("Log Out"),
                    onTap: () async {
                      await Get.put(AuthController()).signoutMethod();
                      Get.offAll(() => MyLogin());
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
