import 'package:flutter/material.dart';
import 'package:staff/add-staff-and-work/workadd.dart';

import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textfield.dart';


class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
    backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
    foregroundColor: Colors.white,
    title: const Text("WORK DETAILS"),
    centerTitle: true,
  
  
  ),
  body: const CostomSerchBar(
    // controller: ,
  ),
      

        floatingActionButton: FloatingActionButton(child: Icon(Icons.add ,color: Colors.white,),onPressed: (){
       navigatepush(context, const Workadd());
      },backgroundColor: const  Color.fromRGBO(22, 38, 52, 1),),
    );
    
  }
}