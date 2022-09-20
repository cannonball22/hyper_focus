import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyper_focus/screens/start_session_screen.dart';
import '../screens/live_session.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../services/buildgraph.dart';
import '../widgets/blurry_title.dart';
import 'live_stat.dart';
import 'on_boarding_screen.dart';
import '../constants';
import 'package:image_stack/image_stack.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    Key? key,
    required this.courseName,
    required this.instructorName,
    required this.courseDate,
    required this.instructorImage,
    required this.courseID,
    required this.courseDescription,
    required this.courseColor,
    required this.instructorID,
  }) : super(key: key);

  final String courseName;
  final String instructorName;
  final String courseDate;
  final String instructorImage;
  final String courseID;
  final String courseDescription;
  final int courseColor;
  final String instructorID;

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  var colorMap = [
    0xff2C2C2E,
    0xffFF6482,
    0xff8944AB,
    0xff262641,
    0xffC93400,
    0xff316676,
  ];

  QuerySnapshot? querySnapshot;
  QuerySnapshot? querySnapshot2;

  bool isLive = false;
  Timestamp? sessionDate;

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? userID;
  String? sessionId;
  dynamic attendanceAverage = <ChartData>[];
  dynamic hyperFocus = <ChartData>[];
  dynamic popQuizAverage = <ChartData>[];
  List<ChartData> attendanceData = [];
  List<ChartData> hyperFocusData = [];
  List<ChartData> popQuizData = [];
  List<String> images = [];

  Stream getStatData() async* {
    yield await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .get()
        .then((result) {
      attendanceAverage = result.get('attendanceAverage');
      hyperFocus = result.get('hyperFocus');
      popQuizAverage = result.get('quizAverage');
      for (int interval = 0; interval < 30; interval++) {
        attendanceData
            .add(ChartData(x: interval, y: attendanceAverage[interval]));
        hyperFocusData.add(ChartData(x: interval, y: hyperFocus[interval]));
        popQuizData.add(ChartData(x: interval, y: popQuizAverage[interval]));
      }
    });
  }

  Stream getActiveSession() async* {
    user = auth.currentUser;
    userID = user?.uid;
    await FirebaseFirestore.instance
        .collection("courses")
        .doc(widget.courseID)
        .collection('sessions')
        .where("live", isEqualTo: true)
        .get()
        .then((results) {
      querySnapshot = results;
      if (querySnapshot != null) {
        isLive = querySnapshot?.docs[0].get('live');
        sessionDate = querySnapshot?.docs[0].get('session date');
        sessionId = querySnapshot?.docs[0].id;
        //print(sessionId);
      }
    });
    yield await FirebaseFirestore.instance
            .collection("courses")
            .doc(widget.courseID)
            .collection('sessions')
            .doc(sessionId)
            .collection("participants")
            .get()
            .then((results) {
          for (int i = 0; i < 3; i++) {
            images.add(results.docs[i].get("imageUrl"));
          }
        }) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    attendanceData.clear();
    hyperFocusData.clear();
    super.initState();
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Clipboard.setData(ClipboardData(text: widget.courseID));
        const snackBar = SnackBar(
          content: Text('Course ID is copied to your clipboard'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BlurryTitle(
        title: "Course details",
      ),
      body: StreamBuilder(
          stream: getActiveSession(),
          builder: (context, snapshot1) {
            return StreamBuilder(
              stream: getStatData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 14.5,
                                      right: 14.5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.courseName,
                                                    style: TextStyle(
                                                      fontSize: 32,
                                                      fontFamily:
                                                          "AvantGarde Bk BT",
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0),
                                                      color: Colors.white,
                                                    ),
                                                    //height: 36,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6.0,
                                                              bottom: 6,
                                                              right: 8,
                                                              left: 8),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 12,
                                                            backgroundImage:
                                                                NetworkImage(widget
                                                                    .instructorImage),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            widget
                                                                .instructorName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "SF UI Display",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    widget.courseDate,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "SF UI Display",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuButton<int>(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              onSelected: (item) =>
                                                  onSelected(context, item),
                                              icon: Icon(
                                                Icons.more_vert,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              itemBuilder: (context) => [
                                                PopupMenuItem<int>(
                                                  value: 0,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.copy,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "Copy to clipboard",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem<int>(
                                                  value: 1,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.settings,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "Modify",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, left: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Description",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "SF UI Display",
                                                fontSize: 24,
                                                letterSpacing: -0.41,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              widget.courseDescription,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "SF Pro Text",
                                                fontSize: 14,
                                                letterSpacing: -0.41,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "14 Sessions",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "SF Pro Text",
                                              letterSpacing: -0.41,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Image(
                                            image: AssetImage(
                                                "assets/icons/Ellipse 72.png"),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "1 Hour",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "SF Pro Text",
                                              letterSpacing: -0.41,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      if (userID == widget.instructorID &&
                                          isLive == false)
                                        Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff30DB5B),
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      StartSessionScreen(
                                                    courseID: widget.courseID,
                                                    courseName:
                                                        widget.courseName,
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
                                      if (userID == widget.instructorID &&
                                          isLive == true)
                                        Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF453A),
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("courses")
                                                  .doc(widget.courseID)
                                                  .collection("sessions")
                                                  .doc(sessionId)
                                                  .update(
                                                {"live": false},
                                              );
                                              setState(() {
                                                isLive = false;
                                              });
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
                                height: 16,
                              ),
                              if (isLive == true)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            querySnapshot?.docs[0]
                                                .get("session title"),
                                            style: kHeader3TextStyle,
                                          ),
                                          Text(
                                            "34:22",
                                            style: kBodyBoldTextStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ImageStack(
                                            imageList: images,
                                            totalCount: images
                                                .length, // If larger than images.length, will show extra empty circle
                                            imageRadius:
                                                25, // Radius of each images
                                            imageCount:
                                                3, // Maximum number of images to be shown in stack
                                            imageBorderWidth:
                                                2, // Border width around the images
                                          ),
                                          SizedBox(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (userID !=
                                                    widget.instructorID) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OnBoardingScreen(
                                                              courseName: widget
                                                                  .courseName,
                                                              courseUID: widget
                                                                  .courseID,
                                                              sessionId:
                                                                  sessionId),
                                                    ),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LiveStat(
                                                        courseName:
                                                            widget.courseName,
                                                        courseID:
                                                            widget.courseID,
                                                        sessionID: sessionId,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            top: 16,
                                                            bottom: 16)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size(116, 48)),
                                              ),
                                              child: Text(
                                                "Join",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  letterSpacing: -0.41,
                                                  fontFamily: "SF Pro Text",
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Class Overview",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "AvantGarde Bk BT",
                                          letterSpacing: -0.02,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Your student’s average results",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SF Pro Text",
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                            buildStat(
                                                "Pop Quiz",
                                                popQuizData.isNotEmpty
                                                    ? attendanceData.last.y
                                                    : 0,
                                                context)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ClassOverviewStat(
                                          "Attendance",
                                          "Minutes attended",
                                          const Color(0xff30DB5B),
                                          attendanceData),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ClassOverviewStat(
                                          "Hyper focus",
                                          "Minutes spent focused on the screen",
                                          const Color(0xffFF9500),
                                          hyperFocusData),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ClassOverviewStat(
                                          "Pop Quiz",
                                          "Pop quiz average results",
                                          const Color(0xffFF2D55),
                                          popQuizData),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }),
    );
  }

  Widget ClassOverviewStat(String keyIndicator, String description, Color colur,
      List<ChartData> dataList) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colur, borderRadius: BorderRadius.circular(16)),
                height: 70,
                width: 9,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    keyIndicator,
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "AvantGarde Bk BT",
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: "SF Pro Text",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: -0.41,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: SfCartesianChart(
              title: ChartTitle(
                text: "Average Rate Past 30 Days",
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: "SF Pro Text",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.41,
                ),
              ),
              plotAreaBorderWidth: 0,
              trackballBehavior: TrackballBehavior(
                activationMode: ActivationMode.singleTap,
                enable: true,
                tooltipSettings:
                    const InteractiveTooltip(enable: true, color: Colors.red),
              ),
              primaryXAxis: NumericAxis(
                maximum: 30,
                minimum: 0,
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(
                maximum: 100,
                minimum: 0,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(
                  color: Color(0xff9797AA),
                  width: 1.5,
                ),
              ),
              series: [
                LineSeries(
                  width: 8,
                  color: Colors.green,
                  dataSource: dataList,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
