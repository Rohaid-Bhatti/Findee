
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/models/ads_model.dart';
import 'package:flutter/material.dart';

class AdsProvider with ChangeNotifier {
  List<AdsModel> adsByCategoryList = [];
  List<AdsModel> adsUserList = [];
  List<AdsModel> adsList = [];

  // ads according to the category
  Future getAdsByCategory(String category) async {
    AdsModel adsModel;
    List<AdsModel> newList = [];

    QuerySnapshot data = await firestore.collection(adsCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        if (category == element.get("category")) {
          adsModel = AdsModel.fromJson(element.data());
          newList.add(adsModel);
          notifyListeners();
        }
      }
    }
    adsByCategoryList = newList;
    notifyListeners();
    return adsByCategoryList;
  }

  //get ads data according to the user id
  Future getAdsData(String userId) async {
    AdsModel adsUserModel;
    List<AdsModel> newList2 = [];

    QuerySnapshot data = await firestore.collection(adsCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        if (userId == element.get("userId")) {
          adsUserModel = AdsModel.fromJson(element.data());
          newList2.add(adsUserModel);
          notifyListeners();
        }
      }
    }
    adsUserList = newList2;
    notifyListeners();
    return adsUserList;
  }

  Future getAds() async {
    AdsModel adsModelData;
    List<AdsModel> newList = [];

    QuerySnapshot data = await firestore.collection(adsCollection).get();
    for (var element in data.docs) {
      if (element.exists) {
        adsModelData = AdsModel.fromJson(element.data());
        newList.add(adsModelData);
        notifyListeners();
      }
    }
    adsList = newList;
    notifyListeners();
    return adsList;
  }

}