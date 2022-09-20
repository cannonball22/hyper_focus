import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyper_focus/screens/courses_screen.dart';
import '../constants';
import '../main.dart';
import '../screens/home_screen.dart';
import '../widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  String _userName = '';
  File? _userImageFile;
  bool _isLogin = true;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return user;
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image.'),
          // backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    //print(isValid);
    if (isValid != null && isValid && _formKey.currentState != null) {
      _formKey.currentState?.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword,
        _userName,
        _userImageFile!,
        _isLogin,
        context,
      );
      // User those values to send out auth request...
    }
    await loginUsingEmailPassword(
        password: _userPassword, context: context, email: _userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        toolbarHeight: 180,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/icons/logo.svg',
                color: Theme.of(context).colorScheme.onBackground),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 24, bottom: 16, left: 20, right: 20),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!_isLogin) UserImagePicker(_pickedImage),
                        TextFormField(
                          key: const ValueKey('email'),
                          validator: (value) {
                            if (value == null || !(value.contains("@"))) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email",
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                            ),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          onChanged: (value) {
                            _userEmail = value;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (!_isLogin)
                          Column(
                            children: [
                              TextFormField(
                                key: const ValueKey('displayName'),
                                validator: (value) {
                                  if (value == null || value.length < 4) {
                                    return 'Please display Name enter at least 4 characters';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Display Name",
                                  filled: true,
                                  fillColor: Theme.of(context).cardColor,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    letterSpacing: -0.41,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    fontFamily: "SF Pro Text",
                                  ),
                                ),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                onChanged: (value) {
                                  _userName = value;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        TextFormField(
                          key: const ValueKey('password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length < 7) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              letterSpacing: -0.41,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                            ),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          onChanged: (value) {
                            _userPassword = value;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (widget.isLoading) const CircularProgressIndicator(),
                        if (!widget.isLoading)
                          Container(
                            height: 59,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(13),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (!_isLogin) {
                                  _trySubmit();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CoursesScreen(),
                                    ),
                                  );
                                } else {
                                  var user = loginUsingEmailPassword(
                                    context: context,
                                    email: _userEmail,
                                    password: _userPassword,
                                  );
                                  if (user != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CoursesScreen(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                _isLogin ? 'Login' : 'Create Account',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SF Pro Text",
                                  letterSpacing: -0.41,
                                ),
                              ),
                            ),
                          ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                letterSpacing: -0.41,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: "SF Pro Text"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!widget.isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        _isLogin
                            ? "Don’t have an account?"
                            : "Already have an account?",
                        style: kSmallestTextStyle),
                    TextButton(
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
