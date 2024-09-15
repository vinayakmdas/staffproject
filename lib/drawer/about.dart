import 'package:flutter/material.dart';
import 'package:staff/custum/textcostom.dart';

class Aboutscreen
 extends StatelessWidget {
  const Aboutscreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
      title: const Apptext("About Us"),
      foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
     ),
     body: const Padding(
       padding: EdgeInsets.only(left: 20, right: 20),
         
       child: Column(
        children: [
           SizedBox(height: 20,),
         const Row(
          
                    children: [
                     
                         Apptext("Welcome to Staff Sphere ,",fontSize: 23,Colors: Color.fromRGBO(0, 0, 0, 1), fontweight: FontWeight.bold,)
                    ],
                   ),
                   SizedBox( height: 20,),
                   Apptext('''Staff Sphere is a mobile app designed for managing staff members, projects, and tasks efficiently. It offers a comprehensive suite of tools for adding, editing, and deleting staff, as well as managing project milestones and assignments. Key features include:


Staff Management: Add, edit, and delete staff members with personal details like name, contact information, and assigned domains or roles.

Project Management: Easily create and manage projects, assign staff, set deadlines, and track progress.

Task Assignments: Assign tasks to staff members, allowing you to monitor their work and update the status as needed.

Local Data Storage: All information is stored locally using Hive, ensuring quick access and offline capabilities without the need for internet connectivity.

Document Management: Attach files such as images and PDFs to staff profiles and project tasks, keeping everything organized in one place.''')
          
        ],
       ),
     ),
    );
  }
}