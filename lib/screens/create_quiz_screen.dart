import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/blurry_title.dart';

class CreateQuizScreen extends StatefulWidget {
  CreateQuizScreen({Key? key, this.courseID, this.sessionID}) : super(key: key);
  final String? courseID;
  final String? sessionID;
  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();

  String question = '';
  String answer1 = '';
  String answer2 = '';

  String courseDescription = '';

  int? privacyValue = 0;
  List<String> items = ["True & False", "Single Choice", "Multiple Choice"];
  String? selectedItem = "True & False";
  int? _groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlurryTitle(
        title: "Create Quiz",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Set Question",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: const ValueKey('question'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Please enter a valid question.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "set question",
                        filled: true,
                        fillColor: Color(0xff2C2C2E),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0x3CEBEBF5),
                          letterSpacing: -0.41,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "SF Pro Text",
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      onChanged: (value) {
                        setState(() {
                          question = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Set Question Type",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xff2C2C2E),
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: DropdownButton<String>(
                            dropdownColor: const Color(0xff1C1C1E),
                            style: const TextStyle(
                              color: Color(0x3CEBEBF5),
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                            ),
                            items: items
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        color: Color(0x3CEBEBF5),
                                        letterSpacing: -0.41,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        fontFamily: "SF Pro Text",
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: selectedItem,
                            onChanged: (item) => setState(() {
                                  selectedItem = item;
                                })),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Set Answers",
                      style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.35,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff2C2C2E),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Radio(
                                value: 0,
                                groupValue: _groupValue,
                                onChanged: (newValue) {
                                  setState(
                                      () => _groupValue = newValue as int?);
                                },
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: TextFormField(
                                    key: const ValueKey('answer 1'),
                                    validator: (value) {
                                      if (value == null || value.length < 4) {
                                        return 'Please enter a valid answer.';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: "set answer",
                                      filled: true,
                                      fillColor: Color(0xff2C2C2E),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Color(0x3CEBEBF5),
                                        letterSpacing: -0.41,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        fontFamily: "SF Pro Text",
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        answer1 = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: const Color(0xff1C1C1E),
                            width: double.infinity,
                            height: 8,
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _groupValue,
                                onChanged: (newValue) {
                                  setState(
                                      () => _groupValue = newValue as int?);
                                },
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: TextFormField(
                                    key: const ValueKey('answer 2'),
                                    validator: (value) {
                                      if (value == null || value.length < 4) {
                                        return 'Please enter a valid answer.';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: "set answer",
                                      filled: true,
                                      fillColor: Color(0xff2C2C2E),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Color(0x3CEBEBF5),
                                        letterSpacing: -0.41,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        fontFamily: "SF Pro Text",
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        answer2 = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xff2C2C2E),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          final isValid = _formKey.currentState?.validate();
                          FocusScope.of(context).unfocus();
                          if (isValid != null &&
                              isValid &&
                              _formKey.currentState != null) {
                            await FirebaseFirestore.instance
                                .collection("courses")
                                .doc(widget.courseID)
                                .collection("sessions")
                                .doc(widget.sessionID)
                                .collection("quiz")
                                .doc()
                                .set({
                              "status": true,
                              "question": question,
                              "answers": [answer1, answer2],
                              "rightAnswer": _groupValue,
                            });
                            Navigator.of(context).pop(context);
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Something went Wrong!'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text(
                          'Send Quiz',
                          style: TextStyle(
                            color: Color(0xff0A84FF),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "SF Pro Text",
                            letterSpacing: -0.41,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
