import 'package:flutter/material.dart';
import '../widgets/instruction_widget.dart';

class OnBoardingInstructions extends StatelessWidget {
  const OnBoardingInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2C2C2E),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: double.infinity,
      //height: 500,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 32.0, right: 32, bottom: 16, top: 16),
        child: Column(
          children: [
            Align(
              child: Image(
                image: AssetImage("assets/icons/wandering-emoji.png"),
              ),
              alignment: Alignment.topRight,
            ),
            SizedBox(
              height: 36,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You’re almost there",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "you’re one step away from awesomeness",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InstructionWidget(
              textPassed:
                  "It’s required to always position your face towards the front camera.",
              iconPassed: "assets/icons/verified.png",
              //iconPassed: Icons.face,
            ),
            SizedBox(
              height: 16,
            ),
            InstructionWidget(
              textPassed: "Hyper focus will track your attention only.",
              iconPassed: "assets/icons/flag.png",
            ),
            SizedBox(
              height: 16,
            ),
            InstructionWidget(
              textPassed: "No one can see your video feed.",
              iconPassed: "assets/icons/eye-no.png",
            ),
            SizedBox(
              height: 16,
            ),
            InstructionWidget(
              textPassed: "We will need your permission to access your camera.",
              iconPassed: "assets/icons/video.png",
            ),
            SizedBox(
              height: 16,
            ),
            InstructionWidget(
              textPassed: "You can request a break from your instructor.",
              iconPassed: "assets/icons/time.png",
            ),
            SizedBox(
              height: 16,
            ),
            InstructionWidget(
              textPassed:
                  "You can use the overlay feature to enjoy your lecture while using Hyper Focus.",
              iconPassed: "assets/icons/external-link.png",
            ),
          ],
        ),
      ),
    );
  }
}
