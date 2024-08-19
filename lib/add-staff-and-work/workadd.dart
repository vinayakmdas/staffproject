import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:staff/Domain_model_dart/domain.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/model.dart/domainmodel.dart';
import 'package:staff/model.dart/project_model.dart';
import 'package:staff/model.dart/staffmodel.dart';
import 'package:staff/service.dart/add_domain_servicepage.dart';
import 'package:staff/service.dart/project_task_service.dart';
import 'package:staff/service.dart/staff_Data_managing.dart';
import 'package:staff/service.dart/work_Datas.dart';

class Workadd extends StatefulWidget {
  const Workadd({super.key});

  @override
  State<Workadd> createState() => _WorkaddState();
}

class _WorkaddState extends State<Workadd> {
  final  datecontroller=TextEditingController();
  WorkDatas workDatas = WorkDatas();

  // ====== declaring drop items
  String? _selectname;
  List<StaffModel> _staffdrop = [];
  String? _selectDomain;
  List<Domainmodel> _domainlist = [];
  String? _projectdrop;
  List<ProjectModel> _projectList = [];
  final ValueNotifier<File?> _workdoc = ValueNotifier<File?>(null);

// ====All function

  Future<void> staffdata() async {
    StaffDatas staffDatas = StaffDatas();
    await staffDatas.openbox();
    _staffdrop = await staffDatas.getstaffdetails();
    setState(() {});
  }

  Future<void> domaindata() async {
    DomainBox domainBox = DomainBox();
    await domainBox.openBox();
    _domainlist = await domainBox.getDomain();
    setState(() {});
  }

  Future<void> projectdata() async {
    ProjectData projectData = ProjectData();
    await projectData.openBox();
    _projectList = await projectData.getprojectdata();
    setState(() {});
  }

  Future alldropdatas() async {
    await staffdata();
    await domaindata();
    await projectdata();
    await workDatas.openBox();
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alldropdatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
          foregroundColor: Colors.white,
          title: const Text("ADD WORK"),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
              children: [
               SizedBox(
                height: 20,
              ),
              customDropdownField(
                labelText: "Select Staff",
                hintText: "Select staff",
                value: _selectname,
                items: _staffdrop.map((staffname) {
                  return DropdownMenuItem<String>(
                    value: staffname.username,
                    child: Text(staffname.username),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectname = value;
                  });
                },
              )
              ,SizedBox(height: 20,)
          ,customDropdownField(
            labelText: "Select Domain",
             hintText: "select Domain", 
             value: _selectDomain, 
             items: _domainlist.map((domain){
              return DropdownMenuItem<String>(
                value: domain.domain,
                child: Text(domain.domain) );
             }).toList(),
             onChanged: (value){
             setState(() {
               _selectDomain=value;
             });
             }
             )
             ,SizedBox(height: 20),
             customDropdownField(
              
              labelText: "Select project",
               hintText: "Select Project",
               value: _projectdrop, 
               items: _projectList.map((project){
                return DropdownMenuItem(
                  value: project.projet,
                  child: Text(project.projet));
               }).toList(),
               onChanged: (value){
        
                setState(() {
                  _projectdrop=value;
                });
               }
                )
                ,const SizedBox(height: 20,),
                //  i cannot add  text form field
            calender(bordercolor: Colors.white,
            controller: datecontroller ,
             lebelcolor: Colors.white,
              filedcolor: const Color.fromRGBO(22, 38, 52, 1),
              
               suffixicon: IconButton(onPressed: ()async{
                     await _selectDate();
                    
                    }, icon:  const Icon(Icons.calendar_month_outlined,color:Colors.white ,),) 
               , lebelname: "Select Date")

               ,SizedBox(height: 20,)

              , Row(
                children: [
                             const Icon(Icons.attachment_outlined,color: Colors.white,)
                             ,TextButton(onPressed: (){ workdocument();}, child: const Text('Add Atachment',style: TextStyle(color:  Colors.white),))
                ],
              )
              ,Container(
                height: 60,
                      width: 290,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: _workdoc
                      , builder: (cpntext,file,_){

                        return file==null? Center(child: Text(" No Document",style: TextStyle(color:  Colors.white ),)): 
                        ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                  ),
                                );
                      },
)
              )

        
            ],
          ),
        ),
      ),
    );
  }
 Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
    datecontroller .text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  void workdocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _workdoc.value = File(result.files.single.path!);
    }
  }
}
