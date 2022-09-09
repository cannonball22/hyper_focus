import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';
import '../services/get_user_data.dart';
import '../services/auth.dart';
import '../widgets/blurry_title.dart';
import '../widgets/on_boarding_instructions.dart';
import 'live_session.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen(
      {Key? key,
      required this.courseName,
      required this.courseUID,
      required this.sessionId})
      : super(key: key);
  final String courseName;
  final String courseUID;
  final String? sessionId;
  @override
  Widget build(BuildContext context) {
    User? user;
    String? userUID;
    String? userEmail;
    String? userName;

    final FirebaseAuth auth = FirebaseAuth.instance;
    //print("THIS IS CURRENT SESSION ID ${sessionId}");

    return Scaffold(
      appBar: BlurryTitle(title: courseName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OnBoardingInstructions(),
              const SizedBox(
                height: 16,
              ),
              Align(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: TextButton(
                    onPressed: () {
                      //implement biometric auth here

                      GetUserData.getUserData().then((results) {
                        userEmail = results["email"];
                        userName = results["username"];
                      });
                      FirebaseFirestore.instance
                          .collection('courses')
                          .doc(courseUID)
                          .collection('sessions')
                          .doc(sessionId)
                          .collection("participants")
                          .doc(GetUserData.getUserId())
                          .set({
                        "attendance": true,
                        "quiz grade": 0,
                        "hyper focus": 0,
                        "student UID": GetUserData.getUserId(),
                        "student email": userEmail,
                        "student name": userName,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveSession(
                            courseName: courseName,
                            courseID: courseUID,
                            sessionID: sessionId,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                        ),
                        padding: MaterialStateProperty.resolveWith((states) =>
                            const EdgeInsets.only(
                                left: 25, right: 25, top: 18, bottom: 18)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => const Color(0xff2C2C2E))),
                    child: const Text(
                      "Grant Permission",
                      style: TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.BOLD,
                          fontFamily: "SF Pro Text"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
