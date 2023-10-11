import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/categoryPage.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:findee/login.dart';
import 'package:findee/providers/category_provider.dart';
import 'package:findee/screens/contact_screen.dart';
import 'package:findee/screens/help_center_screen.dart';
import 'package:findee/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  CategoryProvider userProvider;

  DrawerWidget({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.userProvider.currentData.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.userProvider.currentData.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            onTap: () {
              // Handle navigation to the settings screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(fromProfile: true)));
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              // Handle navigation to the settings screen
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            likedPage(fromProfile: true)));
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Contact Us'),
            onTap: () {
              // Handle navigation to the settings screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContactUsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HelpCenterPage()));
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
        ],
      ),
    );
  }
}
