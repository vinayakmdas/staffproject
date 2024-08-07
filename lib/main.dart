import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';



import 'package:staff/model.dart/signupmodel.dart';

import 'package:staff/service.dart/signup_Data_Managing.dart';

void main() {
Hive.initFlutter();
Hive.registerAdapter( SignUpModelAdapter());
DataManaging().openBox;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return  MaterialApp(

          home: ButtonNavigationbar(),
          debugShowCheckedModeBanner: false,

    );
  }
}

