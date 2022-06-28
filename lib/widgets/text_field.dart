import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants';

class FormInputField extends StatelessWidget {
  const FormInputField(
      {required this.text,
      required this.pass,
      required this.controller,
      required this.key,
      required this.fun});
  final TextEditingController controller;
  final String text;
  final bool pass;
  final Key key;
  final FormFieldValidator<String> fun;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 44,
        width: 375,
        child: TextFormField(
          key: key,
          validator: fun,
          controller: controller,
          /*
          decoration: BoxDecoration(
            color: Color(0xff2C2C2E),
          ),
          obscureText: pass,
          suffix: Padding(
            padding: const EdgeInsets.only(right: 8.0),
          ),*/
          //placeholder: text,
          obscureText: pass,
          decoration: InputDecoration(
            hintText: text,
            filled: true,
            fillColor: Color(0xff2C2C2E),
            border: InputBorder.none,
            hintStyle: const TextStyle(
              color: Color(0x3CEBEBF5),
              letterSpacing: -0.41,
              fontWeight: FontWeight.w400,
              fontSize: 17,
              fontFamily: "SF Pro Text",
            ),
          ),
          //cursorColor: Colors.bl,
          style: const TextStyle(
            color: Colors.white,
          ),
          maxLines: 1,
        ),
      ),
      const SizedBox(
        height: 16,
      ),
    ]);
  }
}
