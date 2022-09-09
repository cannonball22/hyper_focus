import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskForBreak extends StatefulWidget {
  const AskForBreak({Key? key}) : super(key: key);

  @override
  _AskForBreakState createState() => _AskForBreakState();
}

class _AskForBreakState extends State<AskForBreak> {
  int? groupValue = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: 375,
          height: 278,
          decoration: const BoxDecoration(
            color: Color(0xff1E1E1E),
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          padding:
              const EdgeInsets.only(left: 16.0, right: 16.0, top: 8, bottom: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text(
                      "Ask for A break",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SF Pro Text",
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Please enter your reason and Expected duration",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SF Pro Text",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        hintText: 'State a reason'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<int>(
                      groupValue: groupValue,
                      backgroundColor: Color(0x3D767680),
                      thumbColor: Color(0xff636366),
                      children: {
                        5: Text(
                          "5 mins",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF Pro Text",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        10: Text(
                          "10 mins",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF Pro Text",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        15: Text(
                          "15 mins",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "SF Pro Text",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      },
                      onValueChanged: (groupValue) {
                        setState(() {
                          this.groupValue = groupValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0xA6545458),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Ask",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff007AFF),
                        fontSize: 17,
                        fontFamily: "SF Pro Text"),
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
