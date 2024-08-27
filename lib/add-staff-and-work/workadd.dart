import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:staff/Domain_model/domain.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textfield.dart';
import 'package:staff/model.dart/domainmodel.dart';
import 'package:staff/model.dart/project_model.dart';
import 'package:staff/model.dart/staffmodel.dart';
import 'package:staff/model.dart/work_model.dart';
import 'package:staff/pdfview.dart';
import 'package:staff/service/add_domain_servicepage.dart';
import 'package:staff/service/project_task_service.dart';
import 'package:staff/service/staff_Data_managing.dart';
import 'package:staff/service/work_Datas.dart';
import 'package:path_provider/path_provider.dart';

class Workadd extends StatefulWidget {
  const Workadd({super.key});

  @override
  State<Workadd> createState() => _WorkaddState();
}

class _WorkaddState extends State<Workadd> {
  final datecontroller = TextEditingController();
   final descritioncontroller = TextEditingController();
  WorkDatas workDatas = WorkDatas();

  // ====== declaring drop items
  String? _selectname;
  List<StaffModel> _staffdrop = [];
  String? _selectDomain;
  List<Domainmodel> _domainlist = [];
  String? _projectdrop;
  List<ProjectModel> _projectList = [];
  final ValueNotifier<File?> _workimage = ValueNotifier<File?>(null);

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
          
          saveworks()async{
         
          final   date =datecontroller.text.trim();
          final description= descritioncontroller.text.trim();
          final _image= _workimage.value?.path;

            if(_selectname!=null && date.isNotEmpty&& _selectDomain!=null&&_projectdrop!=null
            && _image!=null && description.isNotEmpty  ){
             DateFormat dateFormat = DateFormat("dd/MM/yyyy"); 
               DateTime calendarDate = dateFormat.parse(date);
                   WorkModel workModel= WorkModel(
                    staffname: _selectname.toString(),
                     domainname: _selectDomain.toString(),
                      project:  _projectdrop.toString(),
                       calendarDate: calendarDate , 
                       fileproperties: _image,
                        description: description
                        );
                        workDatas.addwork(workModel);
                        Navigator.of(context).popUntil((route) => route.isFirst);
      navigatepushreplacement(
        context,
        const ButtonNavigationbar(currentPage: 2),
      );
            }
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
              const SizedBox(
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
              ),
              const SizedBox(
                height: 20,
              ),
              customDropdownField(
                  labelText: "Select Domain",
                  hintText: "select Domain",
                  value: _selectDomain,
                  items: _domainlist.map((domain) {
                    return DropdownMenuItem<String>(
                        value: domain.domain, child: Text(domain.domain));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectDomain = value;
                    });
                  }),
              const SizedBox(height: 20),
              customDropdownField(
                  labelText: "Select project",
                  hintText: "Select Project",
                  value: _projectdrop,
                  items: _projectList.map((project) {
                    return DropdownMenuItem(
                        value: project.projet, child: Text(project.projet));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _projectdrop = value;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
            
              calender(
                  bordercolor: Colors.white,
                  controller: datecontroller,
                  lebelcolor: Colors.white,
                  filedcolor: const Color.fromRGBO(22, 38, 52, 1),
                  suffixicon: IconButton(
                    onPressed: () async {
                      await _selectDate();
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                    ),
                  ),
                  lebelname: "Select Date"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.attachment_outlined,
                    color: Colors.white,
                  ),
                  TextButton(
                      onPressed: () {
                        workdetails();
                      },
                      child: const Text(
                        'Add Atachment',
                        style: TextStyle(color: Colors.white),
                      ))
                      
                ],
                
              ),
              const SizedBox( height: 20,)
               ,GestureDetector(
                          
                onTap: (){
                    if (_workimage.value != null && _workimage.value!.path.endsWith('.pdf')){
                      Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => PdfViewerScreen(pdfFile: _workimage.value!),
        ),
      );

                    }
                },
                 child: Container(
                         height: 200,
                  width: 290,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                   child: ValueListenableBuilder<File?>(
                    valueListenable:_workimage,
                    builder: (context, file, _) {
                      if (file == null) {
                        return const Center(
                            child: Text("No Document",
                                style: TextStyle(color: Colors.white)));
                      }
                 
                      final fileExtension =
                          file.path.split('.').last.toLowerCase();
                 
                      if (fileExtension == 'pdf') {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.picture_as_pdf,
                                  size: 50, color: Colors.red),
                              Text('PDF File: ${file.uri.pathSegments.last}',
                                  style:const TextStyle(color: Colors.white)),
                            ],
                          ),
                        );
                      } else if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            file,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (['doc', 'docx'].contains(fileExtension)) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.description,
                                  size: 50, color: Colors.blue),
                              Text('Document File: ${file.uri.pathSegments.last}',
                                  style:const TextStyle(color: Colors.white)),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text('Unsupported File Type',
                                style: TextStyle(color: Colors.white)));
                      }
                    },
                  ),
                 
                 
                        ),
               ) 
               ,const SizedBox(height: 20,) 
              , const Row(
                children: [
                  Text("Add Descrption",style: TextStyle(color: Colors.white),)  
                ],
               )
               ,const SizedBox(height: 20,)
               ,Descritton(
                controller:descritioncontroller, 
                bordercolor: Colors.white) 
                ,const SizedBox(height: 20,)
                ,Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                        saveworks();
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Color.fromRGBO(22, 38, 52, 1),),
                        ),
                      ),
                  ],
                )
           
            ],
          ),
        ),
      ),
    );
  }
// ============================calender
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      datecontroller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

//  ====================================================================================bottom sheet 

  workdetails(){
    showModalBottomSheet(
       backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      context: context,
     builder: (builder){
                return  Padding(
      padding: const EdgeInsets.only(top: 65),
      child: SizedBox( width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/4
      ,child: 
      
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Column(
          children: [
             Row(
              children: [ 
                const Icon(Icons.camera_enhance_outlined,color: Colors.white,),
                TextButton(onPressed: (){
                        cameraimage();
                }, child:  const Text("Camera",style: TextStyle(color: Colors.white), ))
              ],
             ) 
             ,const SizedBox(height: 20,)
             ,Row(
              children: [ 
                const Icon(Icons.add_to_drive_rounded,color: Colors.white,),
                TextButton(onPressed: (){  imagefile();}, child:  const Text("Gallery",style: TextStyle(color: Colors.white), ))
              ],
             )
               ,const SizedBox(height: 20,)
             ,Row(
              children: [ 
                const Icon(Icons.picture_as_pdf,color: Colors.white,),
                TextButton(onPressed: (){ pdfFile();}, child:  const Text("PDF",style: TextStyle(color: Colors.white), ))
              ],
             )
             ,
                      
             
          ],
                 ),
        )
      
      ),
    );
     });
    //  ============================================================================  caamera pdf image
  }
  void cameraimage() async {
    XFile? imagefile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (imagefile == null) return;
    Directory dir = await getApplicationDocumentsDirectory();
    File temp = File(imagefile.path);
    File newfile = await temp.copy('${dir.path}/${imagefile.name}');
    _workimage.value = newfile;
  }
  
  void imagefile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image, 
  );

  if (result != null && result.files.single.path != null) {
    _workimage.value = File(result.files.single.path!);
  }
  }
  void pdfFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,  
    allowedExtensions: ['pdf'],  
  );

  if (result != null && result.files.single.path != null) {
    _workimage.value = File(result.files.single.path!);
  }
}
 
}
