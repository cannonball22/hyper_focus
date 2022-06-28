//import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hyper_focus/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:freerasp/android/android_callback.dart';
import 'package:freerasp/android/android_config.dart';
import 'package:freerasp/ios/ios_callback.dart';
import 'package:freerasp/ios/ios_config.dart';
import 'package:freerasp/talsec_app.dart';
import 'package:freerasp/talsec_callback.dart';
import 'package:freerasp/talsec_config.dart';
import '../screens/course_details.dart';
import '../screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/create_an_account_screen.dart';
import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/live_session.dart';
import 'package:flutter/material.dart';

import 'authentication_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _intializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  void initState() {
    super.initState();
    initSecurityState();
  }

  Future<void> initSecurityState() async {
    TalsecConfig config = TalsecConfig(
      // For Android
      androidConfig: AndroidConfig(
        expectedPackageName: 'hyper_focus',
        expectedSigningCertificateHash: 'HASH_OF_YOUR_APP',
        supportedAlternativeStores: ["com.sec.android.app.samsungapps"],
      ),

      // For iOS
      iosConfig: IOSconfig(
        appBundleId: 'YOUR_APP_BUNDLE_ID',
        appTeamId: 'YOUR_APP_TEAM_ID',
      ),

      // Common email for Alerts and Reports
      watcherMail: 'adham.elmasry2012@hotmail.com',
    );

    TalsecCallback callback = TalsecCallback(
      // For Android
      androidCallback: AndroidCallback(
        onRootDetected: () => print('Root detected'),
        onEmulatorDetected: () => print('Emulator detected'),
        onHookDetected: () => print('Hook detected'),
        onTamperDetected: () => print('Tamper detected'),
        onDeviceBindingDetected: () => print('Device binding detected'),
        onUntrustedInstallationDetected: () =>
            print('Untrusted installation detected'),
      ),

      // For iOS
      iosCallback: IOScallback(
        onSignatureDetected: () => print('Signature detected'),
        onRuntimeManipulationDetected: () =>
            print('Runtime manipulation detected'),
        onJailbreakDetected: () => print('Jailbreak detected'),
        onPasscodeChangeDetected: () => print('Passcode change detected'),
        onPasscodeDetected: () => print('Passcode detected'),
        onSimulatorDetected: () => print('Simulator detected'),
        onMissingSecureEnclaveDetected: () =>
            print('Missing secure enclave detected'),
        onDeviceChangeDetected: () => print('Device change detected'),
        onDeviceIdDetected: () => print('Device ID detected'),
      ),

      // Common for both platforms
      onDebuggerDetected: () => print("Debugger detected"),
    );
    TalsecApp app = TalsecApp(
      config: config,
      callback: callback,
    );

    app.start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomeScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //Means that the user is logged in already and hence navigate to HomePage
      return const HomeScreen();
    }
    //The user isn't logged in and hence navigate to SignInPage.
    return AuthScreen();
  }
}
