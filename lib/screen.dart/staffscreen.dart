import 'package:flutter/material.dart';
import 'package:staff/add-staff-and-work/staffadd.dart';

import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textfield.dart';

class StaffScreen extends StatelessWidget {
  StaffScreen({super.key});

  final searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        foregroundColor: Colors.white,
        title: Text("STAFF SCREEN"),
        centerTitle: true,
      ),
      body: CostomSerchBar(
        controller: searchcontroller,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          navigatepush(context,  StaffAdd());
        },
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      ),


    );
  }
}
