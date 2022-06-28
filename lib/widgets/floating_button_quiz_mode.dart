import 'package:flutter/material.dart';

class QuizMode extends StatelessWidget {
  const QuizMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      label: Text("Hint"),
      icon: ImageIcon(
        AssetImage("assets/icons/time.png"),
        color: Color(0xff1F89FD),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.only(top: 12, bottom: 12, left: 22.5, right: 22.5)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Color(0xff48484A)),
      ),
    );
  }
}
