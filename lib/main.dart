import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google/Leave_request.dart';
import 'package:google/mobilelogin.dart';
import 'package:google/unused/handle.dart';
import 'package:google/unused/home_page.dart';
import 'package:google/unused/login.dart';
import 'package:google/unused/provider/google_singin.dart';
import 'package:google/splash.dart';
import 'package:provider/provider.dart';
import 'package:google/notification_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcmToken is :' '$fcmToken');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  // await SharedPreference.init();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      //home: Mobile_login(),
    );
  }
}
