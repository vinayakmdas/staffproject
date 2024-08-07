import 'package:flutter/material.dart';
import 'package:staff/custum.dart/AppBar.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(87),
       child: CustomAppBar(title: Text("WorkScreen ",
        style: TextStyle(color: Colors.white, fontSize: 23),
       ),)),
    );
  }
}