import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:staff/model.dart/signupmodel.dart';
import 'package:staff/service.dart/signup_Data_Managing.dart';
import 'package:staff/splashscreens/splashscreen.dart';

void main()async {
Hive.initFlutter();
Hive.registerAdapter( SignUpModelAdapter());
DataManaging().openBox;
SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
  // runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(isLoggedIn: isLoggedIn),
      debugShowCheckedModeBanner: false,
    );
  }
}

