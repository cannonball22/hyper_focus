import 'package:flutter/material.dart';
import '../constants';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C1C1E),
      body: Image.asset('assets/images/splash_screen.png'),
    );
  }
}
