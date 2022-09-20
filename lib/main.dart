import 'package:firebase_auth/firebase_auth.dart';
import 'package:hyper_focus/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freerasp/android/android_callback.dart';
import 'package:freerasp/android/android_config.dart';
import 'package:freerasp/ios/ios_callback.dart';
import 'package:freerasp/talsec_app.dart';
import 'package:freerasp/talsec_callback.dart';
import 'package:freerasp/talsec_config.dart';
import 'package:hyper_focus/screens/courses_screen.dart';
import './screens/home_screen.dart';

import './services/notification_api.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi.init();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initSecurityState();
    tz.initializeTimeZones();
  }

  Future<void> initSecurityState() async {
    TalsecConfig config = TalsecConfig(
      // For Android
      androidConfig: AndroidConfig(
        expectedPackageName: 'com.hyper.focus',
        expectedSigningCertificateHash:
            'km1w9w4q0THi2uyNWT5o726VWTLL8ZS43bATrNUAXug=',
        supportedAlternativeStores: ["com.sec.android.app.samsungapps"],
      ),
      /*
      // For iOS
      iosConfig: IOSconfig(
        appBundleId: 'YOUR_APP_BUNDLE_ID',
        appTeamId: 'YOUR_APP_TEAM_ID',
      ),*/

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
      navigatorKey: navigatorKey,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff1C1C1E),
        cardColor: const Color(0xff1C1C1E),
        primaryColor: const Color(0Xff007AFF),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0Xff007AFF),
          onPrimary: Color(0xffffffff),
          background: Color(0xff1C1C1E),
          onBackground: Color(0xffffffff),
          surface: Color(0xff2C2C2E),
          onSurface: Color(0xffFFFFFF),
          secondary: Color(0xff3D3D42),
          onSecondary: Color(0xffffffff),
          error: Color(0xffff2d55),
          onError: Color(0xffffffff),
        ),
        primaryColorLight: const Color(0XFF69a8ff),
        primaryColorDark: const Color(0XFF004fcb),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xffF5FAFF),
        cardColor: const Color(0xffffffff),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xff007AFF),
        ),
        colorScheme: const ColorScheme(
          tertiary: Color(0x3C3c3c43),
          brightness: Brightness.light,
          primary: Color(0Xff007AFF),
          onPrimary: Color(0xffFFFFFF),
          background: Color(0xffF5FAFF),
          onBackground: Color(0xff000000),
          surface: Color(0XffE5F2FF),
          onSurface: Color(0xff000000),
          secondary: Color(0xff3D3D42),
          onSecondary: Color(0xffffffff),
          error: Color(0xffff2d55),
          onError: Color(0xffffffff),
        ),
        primaryColor: const Color(0XFF007aff),
        primaryColorLight: const Color(0XFF69a8ff),
        primaryColorDark: const Color(0XFF004fcb),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!"),
            );
          }
          if (snapshot.hasData) {
            return CoursesScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
