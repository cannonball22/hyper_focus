import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hyper_focus/screens/create_course.dart';
import '../widgets/card.dart';
import '../constants';
import '../services/get_user_data.dart';
import 'dart:ui' as ui;

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool yes = false;
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
    await getUserData();
    //await getCourseList();
    await getCourseList2();
  }

/*
  Future getCourseList() async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .get()
        .then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
*/

  Future getCourseList2() async {
    return await FirebaseFirestore.instance
        .collection("courses")
        .where("course UID", whereIn: enrolledCourses)
        .get()
        .then((result) {
      //print(result);
      coursesData = result;
    });
  }

  Future getUserData() async {
    user = auth.currentUser;
    uid = user?.uid;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((result) {
      setState(() {
        userName = result["username"];
        imageUrl = result["image_url"];
        enrolledCourses = result["enrolled courses"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void _modalBottomSheetMenu() {
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 168.0,
            color: const Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xff1C1C1E),
                    borderRadius: BorderRadius.only(
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
                        icon: const ImageIcon(
                          AssetImage("assets/icons/settings.png"),
                          color: Color(0xff0A84FF),
                        ),
                        label: const Text(
                          "Manage courses",
                          style: TextStyle(
                              color: Color(0xff0A84FF),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff1C1C1E))),
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
                        icon: const ImageIcon(
                          AssetImage("assets/icons/plus.png"),
                          color: Color(0xff0A84FF),
                        ),
                        label: const Text(
                          "Create a course",
                          style: TextStyle(
                              color: Color(0xff0A84FF),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff1C1C1E))),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          yes = !yes;
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/icons/hash.png"),
                          color: Color(0xff0A84FF),
                        ),
                        label: const Text(
                          "Join a course with a code",
                          style: TextStyle(
                              color: Color(0xff0A84FF),
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              letterSpacing: -0.41),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff1C1C1E),
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
      backgroundColor: const Color(0xff1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1C1E),
        toolbarHeight: 158,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 32.0, right: 32, left: 32),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hello, $userName",
                          style: kBodyTextTextStyle,
                        ),
                        if (imageUrl != null)
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        if (imageUrl == null)
                          const CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(
                                  "assets/images/no-profile-image-24.jpg"))
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
                          style: TextStyle(
                            fontFamily: "AvantGarde Bk BT",
                            fontSize: 40,
                            color: Colors.white,
                          ),
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
                )
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: runAllFutures(),
        builder: (context, i) {
          //print(coursesData);

          if (coursesData != null) {
            //print(coursesData);
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, right: 32, bottom: 32),
                  child: SingleChildScrollView(
                    child: _showCourses(),
                  ),
                ),
                if (yes)
                  GestureDetector(
                    onTap: () {
                      yes = false;
                    },
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                        color: const Color(0x146F6F6F).withOpacity(0.2),
                      ),
                    ),
                  ),
                if (yes)
                  AlertDialog(
                    backgroundColor: const Color(0x471E1E1E),
                    content: const Text(
                      "Please enter course ID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        fontFamily: "SF Pro Text",
                        letterSpacing: -0.08,
                      ),
                    ),
                    title: const Text(
                      "Join a course",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
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
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid course ID';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  filled: true, fillColor: Color(0xff1C1C1E)),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0x3cEBEBF5),
                                fontWeight: FontWeight.normal,
                                fontSize: 17,
                                fontFamily: "SF Pro Text",
                                letterSpacing: -0.41,
                              ),
                              onChanged: (value) {
                                _joinCode = value;

                                //print(_joinCode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () async {
                                bool connectionResult =
                                    await _joinCourse(_joinCode);
                                if (connectionResult == true) {
                                  yes = false;
                                }
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
                  )
              ],
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
      await FirebaseFirestore.instance
          .collection("users")
          .doc(GetUserData.getUserId())
          .update(
        {
          "enrolled courses": FieldValue.arrayUnion([courseID]),
        },
      );
      return true;
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
                  courseUID: coursesData!.docs[i].id,
                  courseDescription:
                      coursesData?.docs[i].get("course description"),
                  courseColor: coursesData?.docs[i].get("course color"),
                  instructorUID: coursesData?.docs[i].get("instructor UID")),
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
