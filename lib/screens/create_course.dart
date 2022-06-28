import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyper_focus/screens/course_confirm_screen.dart';
import 'package:hyper_focus/widgets/blurry_title.dart';
import 'package:uuid/uuid.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({Key? key}) : super(key: key);

  @override
  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final _formKey = GlobalKey<FormState>();
  String courseName = '';
  String courseDescription = '';
  Timestamp? date;
  int courseColor = 1;
  int? privacyValue = 0;
  var uuid = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C1C1E),
      appBar: const BlurryTitle(title: "Create New Course"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Course Name",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: const ValueKey('courseName'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter a valid course name.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Course Name",
                        filled: true,
                        fillColor: Color(0xff2C2C2E),
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
                          courseName = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Course Description",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: const ValueKey('courseDescription'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter a valid course name.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Course Description",
                        filled: true,
                        fillColor: Color(0xff2C2C2E),
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
                          courseDescription = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Course Color",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 64,
                      decoration: const BoxDecoration(
                          color: Color(0xff2C2C2E),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Radio(
                              fillColor:
                                  MaterialStateProperty.all(Color(0xffFF6482)),
                              value: 1,
                              groupValue: courseColor,
                              onChanged: (int? T) {
                                setState(() {
                                  courseColor = T!;
                                });
                              }),
                          Radio(
                              fillColor:
                                  MaterialStateProperty.all(Color(0xff8944AB)),
                              value: 2,
                              groupValue: courseColor,
                              onChanged: (int? T) {
                                setState(() {
                                  courseColor = T!;
                                });
                              }),
                          Radio(
                              fillColor:
                                  MaterialStateProperty.all(Color(0xff262641)),
                              value: 3,
                              groupValue: courseColor,
                              onChanged: (int? T) {
                                setState(() {
                                  courseColor = T!;
                                });
                              }),
                          Radio(
                              fillColor:
                                  MaterialStateProperty.all(Color(0xffC93400)),
                              value: 4,
                              groupValue: courseColor,
                              onChanged: (int? T) {
                                setState(() {
                                  courseColor = T!;
                                });
                              }),
                          Radio(
                              fillColor:
                                  MaterialStateProperty.all(Color(0xff316676)),
                              value: 5,
                              groupValue: courseColor,
                              onChanged: (int? T) {
                                setState(() {
                                  courseColor = T!;
                                });
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Privacy",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: const Color(0xff2C2C2E),
                          thumbColor: const Color(0xff636366),
                          groupValue: privacyValue,
                          padding: EdgeInsets.all(0),
                          children: {
                            0: buildSegment("Public"),
                            1: buildSegment("Private"),
                          },
                          onValueChanged: (Value) {
                            setState(() {
                              privacyValue = Value;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    /*
                    const Text(
                      "Course schedule",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),*/

                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: const Color(0xff2C2C2E),
                          borderRadius: BorderRadius.circular(16)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CourseConfirm(
                                courseName: courseName,
                                courseDescription: courseDescription,
                                courseColor: courseColor,
                                coursePrivacy: privacyValue,
                                courseId: uuid,
                              ),
                            ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSegment(String text) => Container(
        padding: EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              letterSpacing: -0.08,
              fontFamily: "SF Pro Text",
              fontSize: 13),
        ),
      );
}
