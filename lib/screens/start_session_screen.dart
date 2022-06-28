import 'package:flutter/material.dart';
import 'package:hyper_focus/widgets/blurry_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'home_screen.dart';
import 'live_stat.dart';

class StartSessionScreen extends StatefulWidget {
  const StartSessionScreen(
      {Key? key, required this.courseID, required this.courseName})
      : super(key: key);
  final String courseID;
  final String courseName;

  @override
  _StartSessionScreenState createState() => _StartSessionScreenState();
}

class _StartSessionScreenState extends State<StartSessionScreen> {
  String? _title;
  String? _description;
  var sessionID = const Uuid().v4();
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BlurryTitle(title: "Start a new session"),
      backgroundColor: const Color(0xff1C1C1E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff2C2C2E),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32, bottom: 32, left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Start a session",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: "SF UI Display",
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Enter session details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Title",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            key: const ValueKey('title'),
                            validator: (value) {
                              if (value == null || value.length < 4) {
                                return 'Please enter a valid title.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Title",
                              filled: true,
                              fillColor: Color(0xff1C1C1E),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0x3CEBEBF5),
                                letterSpacing: -0.41,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: "SF Pro Text",
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            onChanged: (value) {
                              setState(() {
                                _title = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            key: const ValueKey('description'),
                            validator: (value) {
                              if (value == null || value.length < 4) {
                                return 'Please enter a valid description.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Description",
                              filled: true,
                              fillColor: Color(0xff1C1C1E),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0x3CEBEBF5),
                                letterSpacing: -0.41,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: "SF Pro Text",
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            onChanged: (value) {
                              setState(() {
                                _description = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xff30DB5B),
                    borderRadius: BorderRadius.circular(13)),
                child: TextButton(
                  onPressed: () {
                    startSession();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LiveStat(
                          courseName: widget.courseName,
                          courseID: widget.courseID,
                          sessionId: sessionID,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Start Session',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SF Pro Text",
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  startSession() async {
    return await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection("sessions")
        .doc(sessionID)
        .set({
      "live": true,
      "session date": dateTime,
      "session description": _description,
      "session title": _title,
    });
  }
}
