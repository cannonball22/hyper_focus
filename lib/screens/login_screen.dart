import 'package:flutter/material.dart';
import 'package:hyper_focus/screens/courses_screen.dart';
import '../screens/sign_up.dart';
import '../widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  //Login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SvgPicture.asset('assets/icons/Logo.svg'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        "Log In",
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
                          onPressed: () async {
                            User? user = await loginUsingEmailPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                context: context);
                            print(user);
                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => CoursesScreen()));
                            }
                          },
                          child: const Text(
                            "Log In",
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
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: "SF Pro Text"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          fontFamily: "SF Pro Text",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.41,
                          color: Color(0xffC7C7CC),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: "SF Pro Text",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.41,
                              color: Color(0xff0A84FF),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
