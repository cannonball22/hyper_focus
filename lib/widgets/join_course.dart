import 'package:flutter/material.dart';

class JoinCourse extends StatelessWidget {
  const JoinCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(72.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xB51E1E1E),
          ),
          height: 184,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Join a course",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF Pro Text",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.41,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Please enter course ID",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF Pro Text",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.08,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  style: TextStyle(
                    color: Color(0x99EBEBF5),
                    fontFamily: "SF Pro Text",
                    fontSize: 17,
                    letterSpacing: -0.41,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Color(0xffEBEBF5),
                  decoration: InputDecoration(
                    fillColor: Color(0xff1C1C1E),
                    hintText: 'Course ID',
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xB51E1E1E),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Join",
                    style: TextStyle(
                      color: Color(0xff0A84FF),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      letterSpacing: -0.41,
                      fontFamily: "SF Pro Text",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
