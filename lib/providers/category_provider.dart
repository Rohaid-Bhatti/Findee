import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/models/category_model.dart';
import 'package:findee/models/user_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  late UserModel currentData;

  Future getCategoryData() async {
    CategoryModel categoryModel;
    List<CategoryModel> newList = [];

    QuerySnapshot data = await firestore.collection(categoryCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        categoryModel = CategoryModel.fromJson(element.data());
        newList.add(categoryModel);
        notifyListeners();
      }
    }
    categoryList = newList;
    notifyListeners();
    return categoryList;
  }

  //for getting user data
  void getUserData() async {
    UserModel userModel;
    var value = await firestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        name: value.get("name"),
        email: value.get("email"),
        image: value.get("image"),
        uid: value.get("uid"),
        phoneNumber: value.get("phoneNumber"),
        password: value.get("password"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }
}