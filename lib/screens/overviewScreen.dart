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
  dynamic attendanceAverage = <ChartData>[];
  dynamic hyperFocus = <ChartData>[];
  dynamic popQuizAverage = <ChartData>[];
  List<ChartData> attendanceData = [];
  List<ChartData> hyperFocusData = [];
  List<ChartData> popQuizData = [];
  int? numberOfParticipants;
  int? submittedUsers;
  endSession() async {
    // update class stat
    attendanceData.clear();
    hyperFocusData.clear();
    double hyperFocusAvg = 0;
    double attendanceAvg = 0;
    double quizAvg = 0;
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
    );

    return await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .update(
      {"live": false},
    );
  }

  Stream getNumberOfParticipants() async* {
    numberOfParticipants =
        await GetCourseStatistics.getNumberOfSessionParticipants(
            courseID: widget.courseID, sessionID: widget.sessionID);
    yield numberOfParticipants;
  }

  Stream getStatData() async* {
    yield await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .collection("sessions")
        .doc(widget.sessionID)
        .get()
        .then((result) {
      int sze = result.get('attendanceAverage');
      attendanceAverage = result.get('attendanceAverage');
      hyperFocus = result.get('hyperFocus');
      popQuizAverage = result.get('popQuizTotalScore');
      submittedUsers = result.get('submittedUsers');
      for (int interval = 0; interval <= 30; interval++) {
        attendanceData
            .add(ChartData(x: interval, y: attendanceAverage[interval]));
        hyperFocusData.add(ChartData(x: interval, y: hyperFocus[interval]));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    attendanceData.clear();
    hyperFocusData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getStatData(),
      builder: (context, snapshot) => StreamBuilder(
        stream: getNumberOfParticipants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff2C2C2E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          bottomLeft: Radius.circular(8),
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
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                              fontWeight: FontWeight.w700,
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
                            const Text(
                              "Class key performance indicators",
                              style: TextStyle(
                                fontFamily: "SF Pro Text",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff1C1C1E),
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
                                          : 0),
                                  buildStat(
                                      "Hyper Focus",
                                      hyperFocusData.isNotEmpty
                                          ? hyperFocusData.last.y
                                          : 0),
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
                                  borderRadius: BorderRadius.circular(13)),
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
                        color: const Color(0xff2C2C2E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Quiz",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "AvantGarde Bk BT",
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Create a new quiz.",
                              style: TextStyle(
                                fontFamily: "SF Pro Text",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color(0xff30DB5B),
                                  borderRadius: BorderRadius.circular(13)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => CreateQuizScreen(
                                          courseID: widget.courseID,
                                          sessionID: widget.sessionID),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Create quiz',
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
                        color: const Color(0xff2C2C2E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Insights",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "AvantGarde Bk BT",
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Findings based on students Hyper Focus results",
                              style: TextStyle(
                                fontFamily: "SF Pro Text",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff1C1C1E),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Quiz average",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "SF Pro Display",
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.35,
                                          ),
                                        ),
                                        Text(
                                          " ${(popQuizAverage / submittedUsers) / 5 * 100} %",
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
                                          : []),
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
                                          : []),
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
      ),
    );
  }
}
