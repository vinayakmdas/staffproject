import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 50, 61),
      body:  
       Center(child: Container(
        height: 240,
        width: 240,
        child: Image(image: AssetImage("lib/assets/splashscreen-photoaidcom-cropped.png"))))
      
       , 
         
    );
  }
}