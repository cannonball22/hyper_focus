import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/buildgraph.dart';
import '../services/getStatistics.dart';
import 'create_quiz_screen.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen(
      {Key? key, required this.courseID, required this.sessionID})
      : super(key: key);
  final String? courseID;
  final String? sessionID;
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  List<ChartData> attendanceData = [];
  List<ChartData> hyperFocusData = [];
  List<ChartData> popQuizData = [];
  int? numberOfParticipants;
  int? submittedUsers;
  QuerySnapshot? participantsData;
  List<dynamic> participantsList = [];
  Timestamp? startTime;
  double hyperFocusAvg = 0.0;
  double attendanceAvg = 0.0;
  double quizAvg = 0.0;

  Stream getNumberOfParticipants() async* {
    numberOfParticipants =
        await GetCourseStatistics.getNumberOfSessionParticipants(
            courseID: widget.courseID, sessionID: widget.sessionID);
    print(numberOfParticipants);
    yield numberOfParticipants;
  }

  endSession() async {
    // update class stat
    /*
    attendanceData.clear();
    hyperFocusData.clear();

    getStatData();

    for (int interval = 0; interval < 2; interval++) {
      attendanceAvg += attendanceAverage[interval];
    }
    for (int interval = 0; interval < 2; interval++) {
      hyperFocusAvg += hyperFocus[interval];
    }
    attendanceAvg = attendanceAvg / 2;
    hyperFocusAvg = hyperFocusAvg / 2;
    quizAvg = (popQuizAverage / submittedUsers) / 5 * 100;

    await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .update(
      {
        "attendanceAverage": FieldValue.arrayUnion([attendanceAvg]),
        "hyperFocus": FieldValue.arrayUnion([hyperFocusAvg]),
        "quizAverage": FieldValue.arrayUnion([quizAvg]),
      },
    );*/
    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .update(
      {
        "live": false,
      },
    );
  }

  Stream getCourseParticipants() async* {
    yield await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .get()
        .then((result) {
      participantsList = result.get("participants");
    });
  }

  Stream getStatData() async* {
    yield await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .collection("participants")
        .get()
        .then((result) {
      participantsData = result;
      for (int i = 0; i < 24; i++) {
        attendanceAvg = 0.0;
        hyperFocusAvg = 0.0;

        for (int j = 0; j < (participantsData?.docs.length ?? 0); j++) {
          try {
            attendanceAvg +=
                participantsData?.docs[j].get("attendanceAverage")["$i"];
          } catch (e) {
            continue;
          }
        }

        for (int j = 0; j < (participantsData?.docs.length ?? 0); j++) {
          try {
            hyperFocusAvg +=
                participantsData?.docs[j].get("hyperFocusAverage")["$i"];
          } catch (e) {
            continue;
          }
        }
        attendanceAvg = (attendanceAvg / (participantsList.length) * 100);
        hyperFocusAvg =
            (hyperFocusAvg / (participantsData?.docs.length ?? 1) * 100);

        attendanceData.add(ChartData(x: i, y: attendanceAvg.toInt()));
        hyperFocusData.add(ChartData(x: i, y: hyperFocusAvg.toInt()));
      }

      // remove trailing zeros // it can be removed using interval method
      for (int i = attendanceData.length - 1; i >= 0; i--) {
        if (attendanceData[i].y == 0) {
          attendanceData.removeAt(i);
        } else {
          break;
        }
      }

      for (int i = hyperFocusData.length - 1; i >= 0; i--) {
        if (hyperFocusData[i].y == 0) {
          hyperFocusData.removeAt(i);
        } else {
          break;
        }
      }

      /*
      // loop through docs
      for (int i = 0; i < (participantsData?.docs.length ?? 0); i++) {
        List<dynamic> attendanceDataList =
            participantsData?.docs[i].get("attendanceAverage");
        List<dynamic> hyperFocusDataList =
            participantsData?.docs[i].get("hyperFocusAverage");
        print(attendanceDataList);

        for (int j = 0; j < attendanceDataList.length; j++) {
          print(attendanceDataList[j]);
          //attendanceAvg.elementAt(j) += attendanceDataList[j];
          attendanceAvg[j] = (attendanceAvg[j]! + attendanceDataList[j])!;
        }
        for (int j = 0; j < hyperFocusDataList.length; j++) {
          hyperFocusAvg[j] = (hyperFocusAvg[j]! + hyperFocusDataList[j])!;
        }
      }
      for (int i = 0; i < (participantsData?.docs.length ?? 0); i++) {
        hyperFocusAvg[i] =
            (hyperFocusAvg[i] / (participantsData?.docs.length ?? 1)) * 100;
        attendanceAvg[i] =
            (attendanceAvg[i] / (participantsData?.docs.length ?? 1)) * 100;
        attendanceData.add(ChartData(x: i, y: attendanceAvg[i].toInt()));
        hyperFocusData.add(ChartData(x: i, y: hyperFocusAvg[i].toInt()));
      }*/

      for (int i = 0; i < result.docs.length; i++) {
        try {
          quizAvg = quizAvg + participantsData?.docs[i].get('quizGrade');
        } catch (e) {
          print("quiz error");
          print(e);
          continue;
        }
      }
      quizAvg = quizAvg / (participantsData?.docs.length ?? 1);
    });
  }

  @override
  void initState() {
    attendanceData.clear();
    hyperFocusData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getNumberOfParticipants(),
      builder: (context, snapshot) => StreamBuilder(
          stream: getCourseParticipants(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder(
                stream: getStatData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Live Overview",
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontFamily: "AvantGarde Bk BT",
                                            color: Color(0xffFF3B30),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 13,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffFF453A),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              decoration: const BoxDecoration(
                                                color: Color(0x996F6F6F),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Image(
                                                    image: AssetImage(
                                                        "assets/icons/user.png"),
                                                  ),
                                                  Text(
                                                    "$numberOfParticipants",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "SF Pro Text",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Class key performance indicators",
                                      style: TextStyle(
                                        fontFamily: "SF Pro Text",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          buildStat(
                                              "Attendance",
                                              attendanceData.isNotEmpty
                                                  ? attendanceData.last.y
                                                  : 0,
                                              context),
                                          buildStat(
                                              "Hyper Focus",
                                              hyperFocusData.isNotEmpty
                                                  ? hyperFocusData.last.y
                                                  : 0,
                                              context),
                                          /*
                                    buildStat(
                                      "Pop Quiz",
                                      popQuizData.isNotEmpty
                                          ? attendanceData.last.y
                                          : 0,
                                    )*/
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF2D55),
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: TextButton(
                                        onPressed: () {
                                          endSession();
                                          Navigator.of(context).pop(context);
                                        },
                                        child: const Text(
                                          'End Session',
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
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Quiz",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: "AvantGarde Bk BT",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Create a new quiz.",
                                      style: TextStyle(
                                        fontFamily: "SF Pro Text",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateQuizScreen(
                                                      courseID: widget.courseID,
                                                      sessionID:
                                                          widget.sessionID),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Create quiz',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
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
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Insights",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: "AvantGarde Bk BT",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Findings based on students Hyper Focus results",
                                      style: TextStyle(
                                        fontFamily: "SF Pro Text",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Quiz average",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        "SF Pro Display",
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.35,
                                                  ),
                                                ),
                                                Text(
                                                  "$quizAvg / 5",
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "SF Pro Text",
                                                    color: Colors.white,
                                                    letterSpacing: -0.41,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          insightsWidget(
                                              "Hyper Focus Rate",
                                              "Average Minutes spent focused on the screen",
                                              "${hyperFocusData.isNotEmpty ? hyperFocusData.last.y : 0} %",
                                              "Live Hyper focus rate",
                                              hyperFocusData.isNotEmpty
                                                  ? hyperFocusData
                                                  : [],
                                              context),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          insightsWidget(
                                              "Attendance Rate",
                                              "Minutes attended",
                                              "${attendanceData.isNotEmpty ? attendanceData.last.y : 0} %",
                                              "Live attendance rate",
                                              attendanceData.isNotEmpty
                                                  ? attendanceData
                                                  : [],
                                              context),
                                          const SizedBox(
                                            height: 32,
                                          ), /*
                                    insightsWidget(
                                        "Pop Quiz",
                                        "Pop quiz average results",
                                        "${popQuizData.isNotEmpty ? popQuizData.last.y : 0} %",
                                        "Average Rate Past 30 Days",
                                        popQuizData.isNotEmpty
                                            ? popQuizData
                                            : []),
                                  */
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
