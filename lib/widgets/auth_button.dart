import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.button_text,
    required this.icon,
  });
  final String button_text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton.icon(
        onPressed: () {
          // Respond to button press
        },
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          primary: Colors.white,
          fixedSize: Size(343, 56),
        ),
        label: Text(
          button_text,
          style: TextStyle(
            fontFamily: "SF Pro Text",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        icon: Image.asset(
          icon,
          height: 25,
          width: 25,
        ),
      ),
      SizedBox(
        height: 8,
      ),
    ]);
  }
}
