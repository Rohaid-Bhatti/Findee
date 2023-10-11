import 'package:findee/constant/firebase_constant.dart';

//get users data
class FirestoreServices {
  static getUser(uid) {
    return firestore.collection(usersCollection).where('uid', isEqualTo: uid).snapshots();
  }
}