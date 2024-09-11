import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/custum/dashboarditem.dart';

import 'package:staff/custum/navigator.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';
import 'package:staff/model/complete_model.dart';
import 'package:staff/model/work_model.dart';
import 'package:staff/service/work_Datas.dart';
import 'package:staff/service/complete_service.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    navigatpushremoveuntil(context, Loginpage());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculate(); 
  
  }
int totalTasks = 0;
    int completedTasks = 0;

    double percentage = 0.0;
    void calculate() async {
      Complete_Datas completeDatas = Complete_Datas();
      WorkDatas workDatas = WorkDatas();

      await completeDatas.openbox();

      List<CompleteModel> completeTasksList = await completeDatas.getdata();

      await workDatas.openBox();
      List<WorkModel> workdatalist = await workDatas.getdata();
      setState(() {
        totalTasks = completeTasksList.length + workdatalist.length;
        completedTasks = completeTasksList.length;
        if (totalTasks > 0) {
          percentage = completedTasks / totalTasks;
        } else {
          percentage = 0.0;
        }
      });
    }


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: const Text(
          "STAGE",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(90, 42, 50, 57).withOpacity(0.4),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(370))),
            child: Padding(
              padding: const EdgeInsets.only(top: 179),
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(
                        Icons.report,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'About us ',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {}),
                  ListTile(
                      leading: const Icon(
                        Icons.security_outlined,
                        color: Colors.white,
                      ),
                      title: const Text('Privacy and policy',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {}),
                  ListTile(
                      leading: const Icon(
                        Icons.note_sharp,
                        color: Colors.white,
                      ),
                      title: const Text('Terms and condition ',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {}),
                  ListTile(
                      leading: const Icon(
                        Icons.connect_without_contact_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(' contact Us ',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {}),
                  ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text(' Log Out ',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromRGBO(22, 38, 52, 1),
                                title: const Text(
                                  'Log out',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Are you sure want to delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                  ElevatedButton(
                                      onPressed: () {
                                        _logout(context);
                                      },
                                      child: const Text('OK'))
                                ],
                              );
                            });
                      }),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: Column(
          children: [
            DashboardItemWidget(
                onTap1: () {},
                onTap2: () {},
                titleOne: "Pending",
                titleTwo: "Complete"),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.orange,
            ),

_buildTimelineTile("Start", isCompleted: true, isFirst: true),
            _buildTimelineTile("25% Complete", isCompleted: percentage >= 0.25),
            _buildTimelineTile("50% Complete", isCompleted: percentage >= 0.50),
            _buildTimelineTile("75% Complete", isCompleted: percentage >= 0.75),
            _buildTimelineTile("100% Complete",
                  isCompleted: percentage == 1.0, isLast: true)


            
        
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineTile(String title,
      {bool isCompleted = false, bool isFirst = false, bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 180),
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          color: isCompleted ? Colors.teal : Colors.red,
        ),
        beforeLineStyle: LineStyle(
          color: isCompleted ? Colors.teal : Colors.red,
        ),
        afterLineStyle: LineStyle(
          color: isCompleted ? Colors.teal : Colors.red,
        ),
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        endChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
                color: isCompleted ? Colors.green : Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
