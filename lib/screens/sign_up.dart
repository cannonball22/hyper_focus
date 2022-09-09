import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';
import '../widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _fullNameController = TextEditingController();
    var _userEmail = '';
    var _userPassword = '';
    var _userName = '';
    var _isLogin = true;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              SvgPicture.asset('assets/icons/Logo.svg'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff3A3A3C),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 24, bottom: 16, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          fontFamily: "SF Pro Display"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: const ValueKey("email"),
                      validator: (value) {
                        if (value != null || !(value!.contains("@"))) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      controller: _emailController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Email",
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
                    ),
                    TextFormField(
                      key: const ValueKey("password"),
                      validator: (value) {
                        if (value != null || !(value!.contains("@"))) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
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
                    ),
                    TextFormField(
                      key: const ValueKey("fullName"),
                      validator: (value) {
                        if (value != null || value!.length < 7) {
                          return 'Name must be at least 4 characters long.';
                        }
                        return null;
                      },
                      controller: _fullNameController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Full Name",
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
                    ),
                    Container(
                      height: 59,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xff0A84FF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
