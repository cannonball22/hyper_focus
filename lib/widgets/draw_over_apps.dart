import 'package:flutter/material.dart';

class DrawOverApps extends StatefulWidget {
  const DrawOverApps({Key? key}) : super(key: key);

  @override
  _DrawOverAppsState createState() => _DrawOverAppsState();
}

class _DrawOverAppsState extends State<DrawOverApps> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xBF1E1E1E),
          ),
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          height: 151 + 16,
          width: 270,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Draw over other apps?",
                      style: TextStyle(
                        fontFamily: "SF Pro Text",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.08,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "We would like permission to display the app on top of other apps, so you can enjoy your live lecture while using Hyper Focus",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SF Pro Text",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.08,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                width: 270,
                color: Color(0xff545458),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Not Now",
                      style: TextStyle(
                        color: Color(0xff0A84FF),
                        fontSize: 17,
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.41,
                      ),
                    ),
                  ),
                  Container(
                    height: 48.5,
                    width: 0.5,
                    color: Color(0xA6545458),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Color(0xff0A84FF),
                        fontSize: 17,
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.41,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
