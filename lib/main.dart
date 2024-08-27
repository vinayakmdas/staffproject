import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/model.dart/complete_model.dart';
import 'package:staff/model.dart/domainmodel.dart';
import 'package:staff/model.dart/project_model.dart';
import 'package:staff/model.dart/signupmodel.dart';
import 'package:staff/model.dart/staffmodel.dart';
import 'package:staff/model.dart/work_model.dart';


import 'package:staff/service/add_domain_servicepage.dart';
import 'package:staff/service/complete_service.dart';
import 'package:staff/service/project_task_service.dart';
import 'package:staff/service/signup_Data_Managing.dart';
import 'package:staff/service/staff_Data_managing.dart';

import 'package:staff/splashscreens/splashscreen.dart';
import 'package:staff/taskadd/project.dart';

bool isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();

  Hive.registerAdapter(SignUpModelAdapter());
  Hive.registerAdapter(DomainmodelAdapter());
  Hive.registerAdapter(StaffModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());
  Hive.registerAdapter(WorkModelAdapter());
  Hive.registerAdapter(CompleteModelAdapter());

  try {
    await DataManaging().openBox();
    await DomainBox().openBox();
    await StaffDatas().openbox();
    await ProjectData().openBox();
    await Complete_Datas().openbox();
    print('All boxes opened successfully');
  } catch (e) {
    print('Error opening boxes: $e');
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false; 
  print('isLoggedIn: $isLoggedIn');

  runApp(MyApp(isLoggedIn: isLoggedIn));
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

