import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

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
      backgroundColor: const Color(0xff1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1C1E),
        elevation: 0,
        toolbarHeight: 180,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/Logo.svg'),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                                decoration: const InputDecoration(
                                  hintText: "Display Name",
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
                            decoration: const BoxDecoration(
                              color: Color(0xff0A84FF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(13),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (!_isLogin) {
                                  _trySubmit();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
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
                                            const HomeScreen(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                _isLogin ? 'Login' : 'Create Account',
                                style: const TextStyle(
                                  color: Colors.white,
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
                ),
              ),
              if (!widget.isLoading)
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
          ),
        ),
      ),
    );
  }
}
