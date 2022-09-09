import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../services/get_user_data.dart';
import '../services/notification_api.dart';
import '../widgets/blurry_title.dart';
import '../widgets/choice_quiz.dart';
import '../widgets/live_session_floating_action_button.dart';
import 'package:intl/intl.dart';

class LiveSession extends StatefulWidget {
  const LiveSession(
      {Key? key,
      required this.courseName,
      required this.courseID,
      required this.sessionID})
      : super(key: key);

  final String courseName;
  final String courseID;
  final String? sessionID;

  @override
  State<LiveSession> createState() => _LiveSessionState();
}

class _LiveSessionState extends State<LiveSession> {
  String question = "";
  bool? status = true;
  dynamic answers;
  Timestamp? startTime;
  DateTime? startDateTime;
  String? startDateString;
  Timestamp? endTime;
  DateTime? endDateTime;
  String? endDateString;
  String? quizID;
  int? rightAnswer;
  Stream getQuizData() async* {
    yield await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .collection("quiz")
        .get()
        .then((result) {
      quizID = result.docs.last.id;

      question = result.docs.last["question"];
      status = result.docs.last["status"];
      answers = result.docs.last["answers"];
      rightAnswer = result.docs.last["rightAnswer"];
      startTime = result.docs.last["startTime"] as Timestamp;
      endTime = result.docs.last["endTime"] as Timestamp;
      startDateTime = startTime?.toDate();
      startDateString = DateFormat('K:mm:ss').format(startDateTime!);
      endDateTime = endTime?.toDate();
      endDateString = DateFormat('K:mm:ss').format(endDateTime!);
      DateTime now = DateTime.now();
      Duration myDuration = const Duration(days: 5);
    });
  }

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  Future<void> onClickedNotification(String? payload) async {
    bool isAuthenticated = await AuthService.authenticateUser();
    if (isAuthenticated) {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseID)
          .collection('sessions')
          .doc(widget.sessionID)
          .collection("participants")
          .doc(GetUserData.getUserId())
          .update(
        {"hyper focus": FieldValue.increment(1)},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NormalMode(
        courseName: widget.courseName,
        courseID: widget.courseID,
        sessionId: widget.sessionID,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: BlurryTitle(
        title: widget.courseName,
      ),
      body: StreamBuilder(
        stream: getQuizData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              status == false) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => NotificationApi.showScheduledNotification(
                    title: widget.courseName,
                    body: "take your attendance",
                    payload: "lol",
                  ),
                  child: const Text(
                    "CLICK ME",
                  ),
                ),
                ChoiceQuiz(
                  question: question,
                  status: status,
                  answers: answers,
                  sessionId: widget.sessionID,
                  courseId: widget.courseID,
                  quizId: quizID,
                  rightAnswer: rightAnswer,
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "There is no available Quiz now!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 24,
                    letterSpacing: -0.41),
              ),
            );
          }
        },
      ),
    );
  }
}
