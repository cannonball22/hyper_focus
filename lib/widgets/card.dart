import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/course_details.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.courseName,
    required this.instructorName,
    required this.courseDate,
    required this.instructorImage,
    required this.courseID,
    required this.courseDescription,
    required this.courseColor,
    required this.instructorUID,
  }) : super(key: key);
  final String courseName;
  final String instructorName;
  final String courseDate;
  final String courseID;
  final String instructorImage;
  final String courseDescription;
  final int courseColor;
  final String instructorUID;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //print(courseUID);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetails(
              courseDate: courseDate,
              courseName: courseName,
              instructorName: instructorName,
              instructorImage: instructorImage,
              courseID: courseID,
              courseDescription: courseDescription,
              courseColor: courseColor,
              instructorID: instructorUID,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff2C2C2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseName,
                            style: const TextStyle(
                              fontSize: 32,
                              fontFamily: "AvantGarde Bk BT",
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              color: Colors.white,
                            ),
                            //height: 36,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 6.0, bottom: 6, right: 8, left: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        NetworkImage(instructorImage),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    instructorName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: "SF UI Display",
                                      fontWeight: FontWeight.bold,
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
                            courseDate,
                            style: const TextStyle(
                              fontFamily: "SF UI Display",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    PopupMenuButton<int>(
                      color: Color(0xff3A3A3C),
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.copy, color: Colors.white),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Copy to clipboard",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.settings, color: Colors.white),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Modify",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                      icon: const Icon(Icons.more_vert,
                          size: 24, color: Color(0xff1F89FD)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Clipboard.setData(ClipboardData(text: courseID));
        const snackBar = SnackBar(
          content: Text('Course ID is copied to your clipboard'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      case 1:
        break;
    }
  }
}

/*
                Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        child: Image.asset('assets/images/calculus II.png'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        height: 92,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: -23,
                        left: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.white,
                          ),
                          height: 36,
                          child: Center(
                              widthFactor: 1.20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage: AssetImage(
                                        'assets/images/dr mahmoud sami.jpeg'),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Dr. Mahmoud Sami",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "SF UI Display",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                )
                SizedBox(
                  height: 30,
                ),*/
