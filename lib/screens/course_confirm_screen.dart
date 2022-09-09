import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_focus/screens/home_screen.dart';
import 'package:hyper_focus/widgets/blurry_title.dart';
import 'package:flutter/services.dart';

class CourseConfirm extends StatelessWidget {
  CourseConfirm(
      {Key? key,
      required this.courseName,
      required this.courseDescription,
      required this.courseColor,
      required this.coursePrivacy,
      required this.courseId})
      : super(key: key);
  final String? courseName;
  final String? courseDescription;
  final int? courseColor;
  final int? coursePrivacy;
  final String courseId;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user;
    String? instructorUID;
    String? userName;
    String? imageUrl;
    createCourse() async {
      user = auth.currentUser;
      instructorUID = user?.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(instructorUID)
          .get()
          .then((results) {
        userName = results["username"];
        imageUrl = results["image_url"];
      });
      await FirebaseFirestore.instance.collection('courses').doc(courseId).set({
        "course name": courseName,
        "course UID": courseId,
        "course description": courseDescription,
        "course color": courseColor,
        "course privacy": coursePrivacy == 1 ? true : false,
        "instructor UID": instructorUID,
        "instructor image": imageUrl,
        "instructor name": userName,
        "course date": "Wednesday, 11:00 - 12:30"
      });
    }

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 40),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              color: const Color(0xff2C2C2E),
              borderRadius: BorderRadius.circular(16)),
          child: TextButton(
            onPressed: () {
              createCourse();
              (courseId);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Text(
              'Create Course',
              style: TextStyle(
                color: Color(0xff0A84FF),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "SF Pro Text",
                letterSpacing: -0.41,
              ),
            ),
          ),
        ),
      ),
      appBar: const BlurryTitle(title: "invite Students"),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: 103,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xff2C2C2E),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Team code",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "AvantGarde Bk BT",
                          letterSpacing: -0.2,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        courseId,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontFamily: "SF Pro Text",
                          letterSpacing: -0.41,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: courseId));
                      const snackBar = SnackBar(
                        content: Text('Course ID is copied to your clipboard'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(Icons.copy),
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            /*
            Container(
              padding: const EdgeInsets.all(8),
              height: 103,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xff2C2C2E),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "AvantGarde Bk BT",
                          letterSpacing: -0.2,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        "www.hyperfocus.io/join/$courseId",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontFamily: "SF Pro Text",
                          letterSpacing: -0.41,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: courseId));
                    },
                    icon: const Icon(Icons.copy),
                    color: Colors.white,
                  )
                ],
              ),
            ),
          */
          ],
        ),
      ),
    );
  }
}
