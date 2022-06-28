import 'package:flutter/material.dart';
import '../constants';
import '../widgets/auth_button.dart';
import './login_screen.dart';
import '../widgets/text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  //MyHomePage({Key? key, required this.title}) : super(key: key);
  //final String title;

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Container(
          width: 343,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                            height: 44,
                            width: 37,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Create account',
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Join our community!',
                            style: TextStyle(
                              color: Color(0xff3C3C43),
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      children: [
                        /*
                        FormInputField(
                          text: 'Full Name',
                          pass: false,
                        ),
                        FormInputField(
                          text: 'Email Address',
                          pass: false,
                        ),
                        FormInputField(
                          text: 'Password',
                          pass: true,
                        ),*/
                        ElevatedButton(
                          onPressed: () {
                            // Respond to button press
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff007AFF),
                            fixedSize: Size(343, 56),
                          ),
                          child:
                              Text('Create account', style: kButtonTextStyle),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text("Already have an account?",
                              style: kRegularLinkTextStyle),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Container(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      child: Column(
                        children: [
                          AuthButton(
                              button_text: 'Log in with Facebook',
                              icon: 'assets/icons/facebook.png'),
                          AuthButton(
                              button_text: 'Log in with Google',
                              icon: 'assets/icons/google.png'),
                          AuthButton(
                              button_text: 'Log in with Microsoft',
                              icon: 'assets/icons/microsoft.png'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
