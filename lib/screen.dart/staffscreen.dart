import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:staff/add-staff-and-work/staffadd.dart';

import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/editsreen.dart/staffedit.dart';
import 'package:staff/model.dart/staffmodel.dart';
import 'package:staff/service.dart/staff_Data_managing.dart';

class StaffScreen extends StatefulWidget {
  StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final searchcontroller = TextEditingController();

  StaffDatas _staffDatas = StaffDatas();
  List<StaffModel> _list = [];
  List<StaffModel>_filterstaffdetails=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStaff();
    searchcontroller.addListener(_onsearchchanged);
  }
 @override
  void dispose() {
    // TODO: implement dispose
    searchcontroller.removeListener(_onsearchchanged);
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(114, 158, 158, 158),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        foregroundColor: Colors.white,
        title: Text("STAFF SCREEN"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CostomSerchBar(controller: searchcontroller),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filterstaffdetails.length,
              itemBuilder: (context, index) {
                final staff = _filterstaffdetails[index];
               
               
                Widget leadingWidget = const CircleAvatar(
                  child: Icon(Icons.person),
                );

                if (staff.image != null && File(staff.image!).existsSync()) {
                  leadingWidget = CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(
                        File(staff.image!)),
                  );
                }

                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                        staff.username,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      subtitle: Text(
                        staff.domain,
                      ),
                      leading: leadingWidget,
                      trailing: Container(
                        constraints: BoxConstraints(maxWidth: 120),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                navigatepush(context, EditStaff(staff: staff,index: index ,),);
                              },
                            ),
                            const SizedBox(width: 8,)
                            ,IconButton(onPressed: (){
                              showalert(context ,index);
                    }, icon: Icon(Icons.delete,color:Colors.redAccent ,))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          navigatepush(context, StaffAdd());
        },
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      ),
    );
  }

  Future<void> loadStaff() async {
    print("Loading staff data");
    await _staffDatas.openbox();
    List<StaffModel> staffList = await _staffDatas.getstaffdetails();
    setState(() {
      _list = staffList;
      _filterstaffdetails=List.from(_list);
    });
  }

  showalert( context,index){
    showDialog(context: context, builder:(context)=>  AlertDialog(
      backgroundColor:   const Color.fromRGBO(22, 38, 52, 1), 
      title: const Text("Delete Staff",style: TextStyle(color: Colors.white),),
      content: const Text("Are you sure you want to delete this\n staff ?",style: TextStyle(color: Colors.white),),
      actions: [
                   ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text("Cancel"),
                   )
                   ,      ElevatedButton(
            onPressed: () {
             
                    _staffDatas.delete(index);
                                     
                                     loadStaff();
                                   Navigator.of(context).pop(); 
            },
            child: const Text("Delete"),
                   )
      ],
    ));
  }
  _onsearchchanged(){
    String quary=searchcontroller.text.toLowerCase();
    setState(() {
      if(quary.isEmpty){
        _filterstaffdetails=List.from(_list);
      } 
      else{
       _filterstaffdetails= _list.where((staff){
        return  staff.username.toLowerCase().contains(quary);
       }).toList();
      }
    });
  }
}
