import 'package:flutter/material.dart';
import 'package:staff/custum/textcostom.dart';

class Terms_And_Condition extends StatelessWidget {
  const Terms_And_Condition({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Apptext("Terms & condition", ),
        centerTitle: true,
        backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
      ),
      
      body:   const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
                         Row(
                      children: [
                           Apptext("Staff Management",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     Apptext("The app allows you to add staff members and manage their details.")    
                     ,SizedBox(height: 10,), 
                     SizedBox(height: 10,)
                    , Row(
                      children: [
                           Apptext("Task Management",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     Apptext("Each staff member can have tasks assigned to them, and you'll need to show how many tasks are pending for each person.")   
                                        ,SizedBox(height: 10,)
                    , Row(
                      children: [
                           Apptext("Milestones",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     Apptext("The app tracks milestones for the tasks, giving progress updates.")
                      ,SizedBox(height: 10,),
                      Row(
                      children: [
                           Apptext("Admin Role",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     Apptext("Only the admin can set terms and conditions for tasks or the app.")   
                      , SizedBox(height: 25,),
                      Row(
                      children: [
                           Apptext("Features Overview",fontSize: 23,Colors: Color.fromRGBO(0, 0, 0, 1), fontweight: FontWeight.bold,)
                      ],
                     ),
                     SizedBox(height: 20)
                     ,Row(
                      children: [
                      Apptext("Admin Role & Terms and Conditions",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''The admin can manage users, add/edit/delete staff members, assign tasks, and update milestones.
        The admin has the exclusive right to define and update terms and conditions that apply to tasks or the app in general.''')
        ,SizedBox(height: 20)
                     ,Row(
                      children: [
                      Apptext("Staff Addition & Management",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''A form where you can input staff details like name, email, phone number, domain, and gender.
Staff list where you can view all staff members, edit their information, or delete them.''')
        ,SizedBox(height: 20)
                     ,Row(
                      children: [
                      Apptext("Task Status",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''Display pending, ongoing, and completed tasks for each staff member.
Use badges or icons to highlight the pending task count next to each staff member's name.''')
 ,SizedBox(height: 20)
                     ,Row(
                      children: [
                      Apptext("Milestone Tracking",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''For each task, milestones (small steps toward task completion) are tracked.
Milestones can be visualized in a progress bar or checklist.''')
   , SizedBox(height: 25,),
                      Row(
                      children: [
                           Apptext("Flutter Implementation Strategy",fontSize: 23,Colors: Color.fromRGBO(0, 0, 0, 1), fontweight: FontWeight.bold,)
                      ],
                     ),
                     SizedBox(height: 20,),
                     Row(
                      children: [
                           Apptext("Admin Role",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext("Use Firebase or a custom authentication system to implement role-based access control. Only users with admin privileges can access certain parts of the app, like adding terms and conditions.")
                      ,SizedBox(height: 10,),
                      SizedBox(height: 20,),
                     Row(
                      children: [
                           Apptext("Staff Screen",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''Create a screen that lists all staff using a ListView.builder and allows editing/deleting staff via buttons inside a ListTile.
Use Hive or SQLite to store staff information locally.''')
                      ,SizedBox(height: 10,),
                        SizedBox(height: 20,),
                     Row(
                      children: [
                           Apptext("Task Management",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''Create a task model with properties like task name, description, deadline, staff assignment, and milestones.
Use Hive to store tasks locally, and add fields for milestone progress''')
                      , SizedBox(height: 20,),
                     Row(
                      children: [
                           Apptext("Pending Task Count",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''In the staff list, show a count of pending tasks next to each staff member's name.
You can use a query to count tasks that are marked as incomplete''')
, SizedBox(height: 20,),
                     Row(
                      children: [
                           Apptext("Milestone Progress",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''For each task, have a list of milestones with checkboxes to track progress.
Use a progress bar to visually show how many milestones have been completed.''')
,SizedBox(height: 20,),
                     Row(
                      children: [
                           Apptext("Terms and Conditions",fontSize:20,Colors: Color.fromRGBO(0, 0, 0, 1),fontweight: FontWeight.w500,)
                      ],
                     ),
                     SizedBox(height: 10,),
                     Apptext('''The admin can update the terms and conditions by navigating to a specific screen that allows editing this data.
These terms can be stored locally or in a remote database (e.g., Firebase) and displayed to users.''')



                                 
            ],
          ),
        ),
      ),
    );
  }
}