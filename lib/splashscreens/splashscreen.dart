import 'package:flutter/material.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';


class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    if (widget.isLoggedIn) {
      navigatepushreplacement(
          context,
          ButtonNavigationbar(
            currentPage: 0,
          ));
    } else {
      navigatepushreplacement(context, Loginpage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Container(
          child: const Image(
            image: AssetImage("lib/asset/gif/loading.gif.gif"),
          ),
        ),
      ),
    );
  }
}
