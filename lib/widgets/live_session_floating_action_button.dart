import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../screens/courses_screen.dart';
import '../screens/live_session.dart';
import '../services/auth.dart';
import '../services/get_user_data.dart';
import '../services/notification_api.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
//late BuildContext context1;
//late String courseName1;
//late String courseUID1;
//late String sessionId1;

void callBack(String tag, BuildContext context) async {
  WidgetsFlutterBinding.ensureInitialized();
  switch (tag) {
    case "simple_button":
      print("Focus button has been clicked");
      print("Focus button has been clicked");
      print("Focus button has been clicked");
      bool isAuthenticated = await AuthService.authenticateUser();
      if (isAuthenticated) {
        await FirebaseFirestore.instance
            .collection('courses')
            .doc("67a0fb0b-0d7d-4c13-8438-5b8ec75bae2b")
            .collection('sessions')
            .doc("10978d00-ae43-494d-81ba-da72ee28859c")
            .collection("participants")
            .doc(GetUserData.getUserId())
            .update(
          {"hyper focus": FieldValue.increment(1)},
        );
      }
      break;
    case "focus_button":
      print("Focus button has been clicked");
      break;
    case "personal_btn":
      print("Personal button has been clicked");
      break;
    default:
      print("OnClick event of $tag");
  }
}

class NormalMode extends StatefulWidget {
  const NormalMode(
      {Key? key,
      required this.courseName,
      required this.courseID,
      required this.sessionId})
      : super(key: key);
  final String courseName;
  final String courseID;
  final String? sessionId;
  @override
  State<NormalMode> createState() => _NormalModeState();
}

class _NormalModeState extends State<NormalMode> {
  User? user;
  String? userUID;
  String? userEmail;
  String? userName;

  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(
        prefMode: SystemWindowPrefMode.BUBBLE);
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    SystemAlertWindow.registerOnClickListener(callBack);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              tooltip: "Ask for a break",
              onPressed: () {},
              icon: ImageIcon(
                AssetImage("assets/icons/time.png"),
                color: Theme.of(context).colorScheme.onPrimary,
                size: 32,
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              onPressed: () async {
                NotificationApi.showScheduledNotification(
                  title: widget.courseName,
                  body: "take your attendance",
                  payload: "lol",
                );
                await LaunchApp.openApp(
                  androidPackageName: "com.microsoft.teams",
                  openStore: true,
                );
/*
                SystemAlertWindow.requestPermissions;

                SystemWindowHeader header = SystemWindowHeader(
                  title: SystemWindowText(
                    text: widget.courseName,
                    fontSize: 24,
                    fontWeight: FontWeight.BOLD,
                    textColor: Colors.white,
                  ),
                  padding: SystemWindowPadding.setSymmetricPadding(12, 12),
                  decoration: SystemWindowDecoration(
                      startColor: const Color(0xff1C1C1E)),
                );

                SystemWindowFooter footer = SystemWindowFooter(
                  buttons: [
                    SystemWindowButton(
                      text: SystemWindowText(
                          text: "Simple button",
                          fontSize: 12,
                          textColor: const Color.fromRGBO(250, 139, 97, 1)),
                      tag: "simple_button",
                      padding: SystemWindowPadding(
                          left: 10, right: 10, bottom: 10, top: 10),
                      width: SystemWindowButton.WRAP_CONTENT,
                      height: SystemWindowButton.WRAP_CONTENT,
                      decoration: SystemWindowDecoration(
                          startColor: Colors.white,
                          endColor: Colors.white,
                          borderWidth: 0,
                          borderRadius: 0.0),
                    ),
                    SystemWindowButton(
                      text: SystemWindowText(
                          text: "Focus button",
                          fontSize: 12,
                          textColor: Colors.white),
                      tag: "focus_button",
                      width: 0,
                      padding: SystemWindowPadding(
                          left: 10, right: 10, bottom: 10, top: 10),
                      height: SystemWindowButton.WRAP_CONTENT,
                      decoration: SystemWindowDecoration(
                          startColor: const Color.fromRGBO(250, 139, 97, 1),
                          endColor: const Color.fromRGBO(247, 28, 88, 1),
                          borderWidth: 0,
                          borderRadius: 30.0),
                    )
                  ],
                  padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
                  decoration: SystemWindowDecoration(
                      startColor: const Color(0xff1C1C1E)),
                  buttonsPosition: ButtonPosition.CENTER,
                );

                // Ask for a break widget
                // DrawOverApps(),
                // ChoiceQuiz(),
                // CongratsWidget(),
                // FaceDetectionAlert(),

                SystemWindowBody body = SystemWindowBody(
                  decoration: SystemWindowDecoration(
                      startColor: const Color(0xff1C1C1E)),
                  rows: [
                    EachRow(
                      columns: [
                        EachColumn(
                          text: SystemWindowText(
                            text: "Some body2",
                            fontSize: 12,
                            textColor: Colors.black45,
                          ),
                        ),
                      ],
                      gravity: ContentGravity.CENTER,
                    ),
                  ],
                  padding: SystemWindowPadding(
                      left: 16, right: 16, bottom: 12, top: 12),
                );

                SystemAlertWindow.showSystemWindow(
                  header: header,
                  body: body,
                  footer: footer,
                  gravity: SystemWindowGravity.TOP,
                  prefMode: SystemWindowPrefMode.BUBBLE,
                  width: SystemWindowButton.MATCH_PARENT,
                  height: SystemWindowButton.MATCH_PARENT,
                );*/
              },
              tooltip: "Overlay mode",
              icon: ImageIcon(
                AssetImage("assets/icons/external-link.png"),
                color: Theme.of(context).colorScheme.onPrimary,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
