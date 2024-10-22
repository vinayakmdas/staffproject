import 'package:flutter/material.dart';
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
  int completedwork = 0;
  int pendingwork = 0;
  int totalstaff = 0;

  @override
  void initState() {
    super.initState();
    showvalues();
  }

  void showvalues() async {
    Complete_Datas completedatas = Complete_Datas();
    WorkDatas workDatas = WorkDatas();
    StaffDatas staffDatas = StaffDatas();

    await completedatas.openbox();
    List<CompleteModel> complete = await completedatas.getdata();
    await workDatas.openBox();
    List<WorkModel> work = await workDatas.getdata();
    await staffDatas.openbox();
    List<StaffModel> staff = await staffDatas.getstaffdetails();
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
          title: Text(
            "HOMESCREEN",
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
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              heading: 'Pending work',
              count: pendingwork,
              color: Colors.red,
            ),
            containerhomescreen(
              icons: Iconsax.people,
              heading: 'Total Staff',
              color: Colors.black,
              count: totalstaff,
            ),
          ],
        ),
      ),
    );
  }

  Widget containerhomescreen({
    required IconData icons,
    required String heading,
    required int count,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Responsive width
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(icons, size: 50, color: color),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
