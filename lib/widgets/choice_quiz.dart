import 'package:flutter/material.dart';

class ChoiceQuiz extends StatefulWidget {
  const ChoiceQuiz({Key? key}) : super(key: key);

  @override
  _ChoiceQuizState createState() => _ChoiceQuizState();
}

class _ChoiceQuizState extends State<ChoiceQuiz> {
  int? _groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          //height: 182,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff1C1C1E),
                  borderRadius: BorderRadius.circular(24),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 16, left: 24, right: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pop Quiz",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.41,
                              fontSize: 24,
                              fontFamily: "SF UI Display",
                            ),
                          ),
                          Text(
                            "00:19",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.41,
                              fontSize: 16,
                              fontFamily: "SF UI Display",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2 + 5 = 7",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.41,
                              fontSize: 17,
                              fontFamily: "SF UI Text",
                            ),
                          ),
                          StatefulBuilder(
                            builder: (context, _setState) {
                              return Column(
                                children: <Widget>[
                                  RadioListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      value: 1,
                                      groupValue: _groupValue,
                                      title: Text(
                                        "True",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.41,
                                          fontFamily: "SF Pro Text",
                                          color: Colors.white,
                                        ),
                                      ),
                                      onChanged: (newValue) => _setState(() =>
                                          _groupValue = newValue as int?)),
                                  RadioListTile(
                                      value: 0,
                                      contentPadding: EdgeInsets.all(0),
                                      groupValue: _groupValue,
                                      title: Text(
                                        "False",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.41,
                                          fontFamily: "SF Pro Text",
                                          color: Colors.white,
                                        ),
                                      ),
                                      onChanged: (newValue) => _setState(() =>
                                          _groupValue = newValue as int?)),
                                ],
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff1C1C1E),
                  borderRadius: BorderRadius.circular(13),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 4.0,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Color(0xff0A84FF),
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.41,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
