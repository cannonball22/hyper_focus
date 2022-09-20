import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user;
String? uid;
String? imageUrl;
String userName = "";

final FirebaseAuth auth = FirebaseAuth.instance;

class GetCourseStatistics {
  static getParticipantsData(
      {required String? courseID, required String? sessionID}) async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(courseID)
        .collection("sessions")
        .doc(sessionID)
        .collection("participants")
        .get()
        .then((result) => result);
  }

  static getCurrentInterval(
      {required String? courseID, required String? sessionID}) async {
    int? interval;
    DateTime? now;
    int? remaining;
    DateTime? startTimeDate;
    Timestamp? startTime;
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(courseID)
        .collection("sessions")
        .doc(sessionID)
        .get()
        .then((result) {
      startTime = result.get("sessionStartTime");
      startTimeDate = startTime?.toDate();
      //print(startTimeDate);
      now = DateTime.now();
      remaining = now?.difference(startTimeDate!).inMinutes;
      //print(remaining);
      for (int i = 0; i < 24; i++) {
        if (i * 5 <= remaining!) {
          interval = i;
        } else {
          return interval;
        }
      }
      return 0;
    });
  }

  static getNumberOfSessionParticipants(
      {required String? courseID, required String? sessionID}) async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(courseID)
        .collection("sessions")
        .doc(sessionID)
        .collection("participants")
        .get()
        .then((result) => result.size);
  }

  // not used yet
  static getNumberOfCourseParticipants(
      {required String? courseID, required String? sessionID}) async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(courseID)
        .collection("sessions")
        .doc(sessionID)
        .collection("participants")
        .get()
        .then((result) => result.size);
  }
}
