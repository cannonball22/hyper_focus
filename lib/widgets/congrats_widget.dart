import 'package:flutter/material.dart';

class CongratsWidget extends StatelessWidget {
  const CongratsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1C1C1E),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 67.0, bottom: 67),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/icons/celebrate.png"),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Image(
                      image: AssetImage("assets/icons/100.png"),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Image(
                      image: AssetImage("assets/icons/like.png"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: TextButton.icon(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage("assets/icons/check-mark.png"),
                  color: Colors.black,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff30DB5B),
                  ),
                ),
                label: Text(""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
