import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../services/getStatistics.dart';
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
  DateTime? startDateTime;
  String? startDateString;
  Timestamp? endTime;
  DateTime? endDateTime;
  String? endDateString;
  String? quizID;
  int? rightAnswer;
  int? interval;
  QuerySnapshot? quizData;
  Stream getCurrentInterval() async* {
    interval = await GetCourseStatistics.getCurrentInterval(
        sessionID: widget.sessionID, courseID: widget.courseID);
    //print(interval);
    yield interval;
  }

  Stream getQuizData() async* {
    yield await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .collection("quiz")
        .where("status", isEqualTo: true)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        quizData = result;
        return quizData;
      }
      return null;
    });
  }
  //print(result.docs[0].data());

  /*
      startTime = result.docs.last["startTime"] as Timestamp;
      endTime = result.docs.last["endTime"] as Timestamp;
      startDateTime = startTime?.toDate();
      startDateString = DateFormat('K:mm:ss').format(startDateTime!);
      endDateTime = endTime?.toDate();
      endDateString = DateFormat('K:mm:ss').format(endDateTime!);
      DateTime now = DateTime.now();
      Duration myDuration = const Duration(days: 5);*/
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
    //List<dynamic> attendanceAverage = [];
    //List<dynamic> hyperFocusAverage = [];
    print(isAuthenticated);
    /*
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection('sessions')
        .doc(widget.sessionID)
        .collection("participants")
        .doc(GetUserData.getUserId())
        .get()
        .then((result) {
      //attendanceAverage = result.get("attendanceAverage");
      //hyperFocusAverage = result.get("hyperFocusAverage");
    });*/
    if (isAuthenticated) {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseID)
          .collection('sessions')
          .doc(widget.sessionID)
          .collection("participants")
          .doc(GetUserData.getUserId())
          .update({
        "attendanceAverage": {"$interval": 1},
        "hyperFocusAverage": {"$interval": 1}
      });
    }
    /*
    if (isAuthenticated) {
      print(hyperFocusAverage);
      attendanceAverage.add(1);
      hyperFocusAverage.add(1);
      print(hyperFocusAverage);
    } else {
      attendanceAverage.add(0);
      hyperFocusAverage.add(0);
    }
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection('sessions')
        .doc(widget.sessionID)
        .collection("participants")
        .doc(GetUserData.getUserId())
        .update(
      {
        "attendanceAverage": attendanceAverage,
        "hyperFocusAverage": hyperFocusAverage,
      },
    );*/
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
        stream: getCurrentInterval(),
        builder: (context, snapshot) => StreamBuilder(
          stream: getQuizData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Center(
                child: ChoiceQuiz(
                  quizId: quizData?.docs[0].id,
                  question: quizData?.docs[0].get("question"),
                  status: quizData?.docs[0].get("status"),
                  answers: quizData?.docs[0].get("answers"),
                  rightAnswer: quizData?.docs[0].get("rightAnswer"),
                  sessionId: widget.sessionID,
                  courseId: widget.courseID,
                ),
              );
            } else {
              return Center(
                child: Text(
                  "There is no available Quiz now!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontFamily: "SF Pro Display",
                      fontSize: 24,
                      letterSpacing: -0.41),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
