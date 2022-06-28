import 'package:flutter/material.dart';

class NormalMode extends StatelessWidget {
  const NormalMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: Color(0xff48484A),
            ),
            child: IconButton(
              tooltip: "Ask for a break",
              onPressed: () {},
              icon: ImageIcon(
                AssetImage("assets/icons/time.png"),
                color: Color(0xff1F89FD),
                size: 32,
              ),
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: Color(0xff48484A),
            ),
            child: IconButton(
              onPressed: () {},
              tooltip: "Overlay mode",
              icon: ImageIcon(
                AssetImage("assets/icons/external-link.png"),
                color: Color(0xff1F89FD),
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
