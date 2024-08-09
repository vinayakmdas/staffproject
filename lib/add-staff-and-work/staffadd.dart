import 'package:flutter/material.dart';


class StaffAdd extends StatelessWidget {
  const StaffAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
  appBar: AppBar(
    backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
    foregroundColor: Colors.white,
    title: Text("ADD STAFF"),
    centerTitle: true,
  
  
  ) ,
      
    );
  }
}