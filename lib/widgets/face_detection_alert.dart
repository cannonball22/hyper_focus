import 'package:flutter/material.dart';

class FaceDetectionAlert extends StatelessWidget {
  const FaceDetectionAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFF2D55),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16, left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Face not detected",
                          style: TextStyle(
                            fontFamily: "SF UI Display",
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                            letterSpacing: -0.41,
                          ),
                        ),
                        Text(
                          "00:15",
                          style: TextStyle(
                            fontFamily: "SF UI Display",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: -0.41,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "We had some problems detecting your face. Are you still watching?",
                      style: TextStyle(
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: Colors.white,
                        letterSpacing: -0.41,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 58,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Continue watching",
                  style: TextStyle(
                    fontFamily: "SF Pro Text",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                    color: Color(0xff0A84FF),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff1C1C1E),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
