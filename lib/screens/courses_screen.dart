import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hyper_focus/screens/create_course.dart';
import '../main.dart';
import '../widgets/card.dart';
import '../constants';
import '../services/get_user_data.dart';
import 'dart:ui' as ui;
import '../authentication_provider.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? uid;
  String userName = "";
  String imageUrl = "";
  dynamic userData;
  String _joinCode = "";
  dynamic enrolledCourses;
  QuerySnapshot? querySnapshot;
  final _formKey = GlobalKey<FormState>();
  QuerySnapshot? coursesData;

  Future runAllFutures() async {
    await GetUserData.getUserData().then((result) {
      setState(() {
        userName = result["userName"];
        imageUrl = result["userImageUrl"];
        enrolledCourses = result["enrolled courses"];
      });
    });
    await getCourseList2();
  }

  Future getCourseList2() async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .where("course UID", whereIn: enrolledCourses)
        .get()
        .then((result) {
      coursesData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _modalBottomSheetMenu() {
      showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (builder) {
          return Container(
            height: 168.0,
            color: const Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage("assets/icons/settings.png"),
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Manage courses",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.background)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateCourse(),
                            ),
                          );
                        },
                        icon: ImageIcon(
                          AssetImage("assets/icons/plus.png"),
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Create a course",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.background)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => Center(
                              child: AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                content: Text(
                                  "Please enter course ID",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    fontFamily: "SF Pro Text",
                                    letterSpacing: -0.08,
                                  ),
                                ),
                                title: Text(
                                  "Join a course",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    fontFamily: "SF Pro Text",
                                    letterSpacing: -0.41,
                                  ),
                                ),
                                actions: [
                                  Column(
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          key: const ValueKey('course id'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter valid course ID';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Theme.of(context).cardColor,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17,
                                            fontFamily: "SF Pro Text",
                                            letterSpacing: -0.41,
                                          ),
                                          onChanged: (value) {
                                            _joinCode = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            bool connectionResult =
                                                await _joinCourse(_joinCode);
                                            if (connectionResult == true) {
                                              navigatorKey.currentState!
                                                  .popUntil(
                                                      (route) => route.isFirst);
                                            } else {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'The code that you have entered is not valid!'),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                            // close show dialog
                                          },
                                          child: const Text(
                                            "Join",
                                            style: TextStyle(
                                              color: Color(0xff0A84FF),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                              fontFamily: "SF Pro Text",
                                              letterSpacing: -0.41,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: ImageIcon(
                          const AssetImage("assets/icons/hash.png"),
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Join a course with a code",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            fontFamily: "SF Pro Text",
                            letterSpacing: -0.41,
                          ),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 158,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 32.0, right: 32, left: 32),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello, $userName",
                      style: kBodyTextStyle,
                    ),
                    PopupMenuButton(
                      color: Theme.of(context).colorScheme.surface,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "Sign Out",
                          child: Text("Sign Out",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                        ),
                      ],
                      onSelected: (String newValue) async {
                        if (newValue == "Sign Out") {
                          await FirebaseAuth.instance.signOut();
                        }
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: CachedNetworkImageProvider(
                          imageUrl,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My courses",
                      textAlign: TextAlign.end,
                      style: kHeader2TextStyle,
                    ),
                    IconButton(
                      onPressed: _modalBottomSheetMenu,
                      icon: const Icon(
                        Icons.more_vert,
                        size: 24,
                        color: Color(0xff1F89FD),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: runAllFutures(),
        builder: (context, i) {
          if (coursesData != null) {
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, right: 32, bottom: 32),
                  child: SingleChildScrollView(
                    child: _showCourses(),
                  ),
                ),
              ],
            );
          } else if (enrolledCourses == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  "You haven't enrolled in any course yet",
                  style: kSubtitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<bool> _joinCourse(String courseID) async {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    //print(" This is course id ,$courseID courseID");
    if (isValid != null && isValid && _formKey.currentState != null) {
      dynamic usersRef =
          FirebaseFirestore.instance.collection('courses').doc(courseID);

      usersRef.get().then((docSnapshot) {
        {
          if (docSnapshot.exists) {
            usersRef.onSnapshot((doc) async => {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(GetUserData.getUserId())
                      .update(
                    {
                      "enrolled courses": FieldValue.arrayUnion([courseID]),
                    },
                  )
                });
            return true;
          } else {
            print("false");
            return false;
          }
        }
      });
    }
    return false;
  }

  _showCourses() {
    if (coursesData != null) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: coursesData?.docs.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              CourseCard(
                courseDate: coursesData?.docs[i].get('course date'),
                courseName: coursesData?.docs[i].get("course name"),
                instructorImage: coursesData?.docs[i].get('instructor image'),
                instructorName: coursesData?.docs[i].get("instructor name"),
                courseID: coursesData!.docs[i].id,
                courseDescription:
                    coursesData?.docs[i].get("course description"),
                courseColor: coursesData?.docs[i].get("course color"),
                instructorUID: coursesData?.docs[i].get("instructor UID"),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        },
      );
    }
    return;
  }
}
