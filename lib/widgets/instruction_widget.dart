import 'package:flutter/material.dart';
import '../constants';
//import 'package:camera/camera.dart';

import '../widgets/card.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget(
      {Key? key, required this.textPassed, required this.iconPassed})
      : super(key: key);
  final String textPassed;
  final String iconPassed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AssetImage(iconPassed),
          color: Colors.white,
        ),
        //Icon(iconPassed, color: Colors.white, size: 24),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            textPassed,
            style: kBodyTextStyle,
          ),
        )
      ],
    );
  }
}
