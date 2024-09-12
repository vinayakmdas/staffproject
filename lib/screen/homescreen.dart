import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:staff/custum/AppBar.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/model/complete_model.dart';
import 'package:staff/model/staffmodel.dart';
import 'package:staff/model/work_model.dart';
import 'package:staff/service/complete_service.dart';
import 'package:staff/service/staff_Data_managing.dart';
import 'package:staff/service/work_Datas.dart';

import 'package:staff/taskadd/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int completedwork=0;
  int pendingwork=0; 
  int totalstaff=0;

     @override
  void initState() {
    // TODO: implement initState
    super.initState();
   showvalues();
                                
  }
     void showvalues()async{
      Complete_Datas completedatas=Complete_Datas();
      WorkDatas workDatas =WorkDatas();
      StaffDatas  staffDatas=StaffDatas();
   



    await completedatas.openbox();
      List<CompleteModel>complete= await  completedatas.getdata();
      await workDatas.openBox();
      List<WorkModel>work= await workDatas.getdata();
      await staffDatas.openbox();
      List<StaffModel>staff= await staffDatas.getstaffdetails();
       setState(() {
           completedwork += complete.length;
       pendingwork += work.length;
       totalstaff += staff.length;
       });
     
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(87),
          child: CustomAppBar(
            title:  Text(
              " HOMESCREEN",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            trailing: IconButton(
                onPressed: () {
                  navigatepush(context, TaskPage());
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 43,
                  color: Colors.white,
                )),
          )),
      body:   SingleChildScrollView(
        child: Column(
          children: [
            containerhomescreen(
              icons: Iconsax.tick_square,
              heading: 'Complete Work',
              count: completedwork, 
              color: Colors.green,
            ),
            containerhomescreen(
              icons: Iconsax.close_square,
              heading: 'Pending work ',
              count: pendingwork,
              color: Colors.red,
            ),
            containerhomescreen(
              icons: Iconsax.people,
              heading: ' Total Staff' ,
              color: Colors.black,
              count:  totalstaff,
              
            )
          ],
        ),
      ),
    );
  }
}
