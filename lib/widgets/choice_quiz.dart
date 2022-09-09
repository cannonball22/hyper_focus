import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/get_user_data.dart';

class ChoiceQuiz extends StatefulWidget {
  const ChoiceQuiz({
    Key? key,
    this.answers,
    required this.question,
    required this.status,
    required this.sessionId,
    required this.courseId,
    required this.quizId,
    required this.rightAnswer,
  }) : super(key: key);
  final String? sessionId;
  final String courseId;
  final String? quizId;
  final String question;
  final bool? status;
  final int? rightAnswer;
  final dynamic answers;
  @override
  _ChoiceQuizState createState() => _ChoiceQuizState();
}

class _ChoiceQuizState extends State<ChoiceQuiz> {
  int? _groupValue = 1;

  submitAnswer(int answer, int? rightAnswer) async {
    if (answer == rightAnswer) {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .collection("sessions")
          .doc(widget.sessionId)
          .update({
        "popQuizTotalScore": FieldValue.increment(1),
        "submittedUsers": FieldValue.increment(1),
      });
    }

    return await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .collection("sessions")
        .doc(widget.sessionId)
        .collection("quiz")
        .doc(widget.quizId)
        .collection("students answers")
        .doc()
        .set({
      "student Name": "Adham Mostafa",
      "StudentID": GetUserData.getUserId(),
      "Student answer": answer,
    });
  }

  late Timer _timer;
  int _start = 300;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff2C2C2E),
                borderRadius: BorderRadius.circular(24),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16, left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pop Quiz",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.41,
                            fontSize: 24,
                            fontFamily: "SF UI Display",
                          ),
                        ),
                        Text(
                          "$_start",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.41,
                            fontSize: 16,
                            fontFamily: "SF UI Display",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.question,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.41,
                            fontSize: 17,
                            fontFamily: "SF UI Text",
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                value: index,
                                groupValue: _groupValue,
                                onChanged: (newValue) {
                                  setState(
                                      () => _groupValue = newValue as int?);
                                },
                                title: Text(
                                  widget.answers[index],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.41,
                                    fontFamily: "SF Pro Text",
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                            itemCount: 2,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff2C2C2E),
                borderRadius: BorderRadius.circular(13),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: TextButton(
                  onPressed: () {
                    submitAnswer(_groupValue!, widget.rightAnswer);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Color(0xff0A84FF),
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff1E1E1E),
                borderRadius: BorderRadius.circular(24),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16, left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pop Quiz",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.41,
                            fontSize: 24,
                            fontFamily: "SF UI Display",
                          ),
                        ),
                        Text(
                          "00:19",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.41,
                            fontSize: 16,
                            fontFamily: "SF UI Display",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "2 + 5 = 7",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.41,
                            fontSize: 17,
                            fontFamily: "SF UI Text",
                          ),
                        ),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              children: <Widget>[
                                RadioListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    value: 1,
                                    groupValue: _groupValue,
                                    title: Text(
                                      "True",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.41,
                                        fontFamily: "SF Pro Text",
                                        color: Colors.white,
                                      ),
                                    ),
                                    onChanged: (newValue) => setState(
                                        () => _groupValue = newValue as int?)),
                                RadioListTile(
                                    value: 0,
                                    contentPadding: const EdgeInsets.all(0),
                                    groupValue: _groupValue,
                                    title: Text(
                                      "False",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.41,
                                        fontFamily: "SF Pro Text",
                                        color: Colors.white,
                                      ),
                                    ),
                                    onChanged: (newValue) => setState(
                                        () => _groupValue = newValue as int?)),
                              ],
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

 */
