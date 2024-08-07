import 'package:flutter/material.dart';
import 'package:staff/custum.dart/AppBar.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/screen.dart/staffadd.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(87),
       child: CustomAppBar(title: Text("Staff SCreen",
        style: TextStyle(color: Colors.white, fontSize: 23),
       ),)),
      

        floatingActionButton: FloatingActionButton(child: Icon(Icons.add ,color: Colors.white,),onPressed: (){
       navigatepush(context, const StaffAdd());
      },backgroundColor: const  Color.fromRGBO(22, 38, 52, 1),),
    );
  }
}