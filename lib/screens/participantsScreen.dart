import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/buildgraph.dart';
import '../services/getStatistics.dart';
import 'package:expandable/expandable.dart';

class ParticipantsScreen extends StatefulWidget {
  const ParticipantsScreen({Key? key, required this.courseID, this.sessionID})
      : super(key: key);

  final String courseID;
  final String? sessionID;

  @override
  _ParticipantsScreenState createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  QuerySnapshot? participantsData;

  Stream getParticipantsData() async* {
    participantsData = await GetCourseStatistics.getParticipantsData(
        courseID: widget.courseID, sessionID: widget.sessionID);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getParticipantsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: participantsData?.docs.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Card(
                    color: const Color(0xff2C2C2E),
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        iconColor: Color(0xff1F89FD),
                      ),
                      header: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                participantsData?.docs[i].get("imageUrl"),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              participantsData?.docs[i].get("userName"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: -0.41,
                                fontWeight: FontWeight.w600,
                                fontFamily: "SF Pro Text",
                              ),
                            )
                          ],
                        ),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Pop quiz Grade",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SF Pro Text",
                                    color: Colors.white,
                                    letterSpacing: -0.41,
                                  ),
                                ),
                                Text(
                                  "${participantsData?.docs[i].get("quizGrade")}",
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
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildStat(
                                "Attendance",
                                participantsData?.docs[i]
                                    .get("attendanceAverage"),
                              ),
                              buildStat(
                                "Hyper focus",
                                participantsData?.docs[i]
                                    .get("hyperFocusAverage"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
