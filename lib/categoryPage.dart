import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/components/categoryComponent.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/constants.dart';
import 'package:findee/providers/category_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class likedPage extends StatefulWidget {
  final bool fromProfile;

  const likedPage({Key? key, required this.fromProfile}) : super(key: key);

  @override
  State<likedPage> createState() => _likedPageState();
}

class _likedPageState extends State<likedPage> {
  CategoryProvider? categoryProvider;

  @override
  void initState() {
    CategoryProvider provider = Provider.of(context, listen: false);
    provider.getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
        automaticallyImplyLeading: false,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: CategoryComponent(categoryProvider: categoryProvider!,),
    );
  }
}
