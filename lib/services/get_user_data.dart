import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user;
String? uid;
String? imageUrl;
String userName = "";

final FirebaseAuth auth = FirebaseAuth.instance;

class GetUserData {
  static String? getUserId() {
    user = auth.currentUser;
    uid = user?.uid;
    return uid;
  }

  static Future getUserData() async {
    user = auth.currentUser;
    uid = user?.uid;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((results) {
      return {
        "userId": uid,
        "userName": results["username"],
        "userEmail": results["email"],
        "userImageUrl": results["image_url"],
        "enrolled courses": results["enrolled courses"],
      };
    });
  }
}
