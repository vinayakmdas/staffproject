import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum.dart/appbaruser.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/model.dart/domainmodel.dart';
import 'package:staff/model.dart/staffmodel.dart';
import 'package:staff/service.dart/add_domain_servicepage.dart';
import 'package:staff/service.dart/staff_Data_managing.dart';
class EditStaff extends StatefulWidget {
  final StaffModel staff;
  final int index;

  EditStaff({super.key, required this.staff,required this .index});

  @override
  State<EditStaff> createState() => _EditStaff();
}

class _EditStaff extends State<EditStaff> {
  final usernameController = TextEditingController();
  final userPhoneNumber = TextEditingController();
  final userEmail = TextEditingController();

 ValueNotifier<String?>image=ValueNotifier<String?>(null);
  List<Domainmodel> _domainList = [];
   ValueNotifier <String?>_selectedDomain=ValueNotifier<String?>(null);
  List<String> _genter = ["Male", "Female", "Other"];
  ValueNotifier<String?>_selectgenter=ValueNotifier<String?>(null);
  ValueNotifier<File?>_selectimage=ValueNotifier<File?>(null);

  StaffDatas _staffDatas = StaffDatas();



  savestaff(){
   final proofImagePath = _selectimage.value?.path;
    final name = usernameController.text.trim();
    final number = userPhoneNumber.text;
    final email = userEmail.text;


    if(proofImagePath!=null&& name.isNotEmpty
         &&number.isNotEmpty&&email.isNotEmpty
         &&_selectedDomain.value!=null&&_genter.isNotEmpty
         &&image.value!=null){

           StaffModel staffModel = StaffModel(
        username: name,
        phonenumber: number,
        email: email,
        domain: _selectedDomain.value!,
        gender: _selectgenter.value!,
        image: image.value,
        proofimage: _selectimage.value?.path,
      );
          _staffDatas.updatevalue(  widget.index, staffModel);
           Navigator.of(context).popUntil((route) => route.isFirst);
    navigatepushreplacement(context, ButtonNavigationbar(currentPage: 1,));

          
         }
         
  }

  @override
  void initState() {
    super.initState();
    firstloading();
    connectdatas();
  }

  Future<void> firstloading() async {
    await fetchDomains();
    await _staffDatas.openbox();
  }

  Future<void> fetchDomains() async {
    DomainBox domainBox = DomainBox();
    await domainBox.openBox();
    _domainList = await domainBox.getDomain();
    if (_domainList.isNotEmpty) {
      _selectedDomain.value = _domainList.first.domain;
    }
    setState(() {});
  }

  void connectdatas() {
    usernameController.text = widget.staff.username;
    userPhoneNumber.text = widget.staff.phonenumber;
    userEmail.text = widget.staff.email;
    image.value = widget.staff.image;
    _selectgenter.value = widget.staff.gender;
    _selectedDomain.value = widget.staff.domain;
    _selectimage.value = widget.staff.proofimage != null ? File(widget.staff.proofimage!) : null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
      appBar: userappbar(context, "EDIT STAFF"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(23),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    image.value == null
                        ? CircleAvatar(
                            radius: 80,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person,
                                size: 90,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(image.value!)),
                          ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          Showimageplace(context, pickimage, cameraimage);
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Color.fromARGB(255, 30, 4, 4),
                          size: 40,
                        ),
                      ),
                      bottom: -8,
                      left: 80,
                    ),
                  ],
                ),
                const SizedBox(height: 43),
                usertextfield(
                  controller: usernameController,
                  lebelname: 'NAME  :',
                ),
                const SizedBox(height: 20),
                usertextfield(
                  controller: userPhoneNumber,
                  lebelname: "PHONE NUMBER  :",
                ),
                const SizedBox(height: 20),
                usertextfield(
                  controller: userEmail,
                  lebelname: "E-MAIL  :",
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 32, 58, 81),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                 child:  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: ValueListenableBuilder<String?>(
                      valueListenable: _selectedDomain,
                      builder: (context, value, _) {
                        return DropdownButton<String>(
                          iconEnabledColor: Colors.black,
                          hint: const Text(
                            "Select Domain",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: value, 
                          onChanged: (String? newValue) {
                            _selectedDomain.value = newValue; 
                          },
                          items: _domainList.map<DropdownMenuItem<String>>((Domainmodel domain) {
                            return DropdownMenuItem<String>(
                              value: domain.domain,
                              child: Text(domain.domain),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 143,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 32, 58, 81),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
  padding: const EdgeInsets.only(left : 12),
  child: ValueListenableBuilder<String?>(
    valueListenable: _selectgenter, 
    builder: (context, value, _) {
      return DropdownButton<String>(
        hint: const Text(
          "Select Gender",
          style: TextStyle(color: Colors.black),
        ),
        items: _genter.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (String? newValue) {
          _selectgenter.value = newValue; // Update ValueNotifier
        },
      );
    },
  ),
),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    proofimage();
                  },
                  child: const Text(
                    "Upload proof",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
                const SizedBox(height: 20),
                DottedBorder(
                  color: Colors.blueAccent,
                  strokeWidth: 2,
                  dashPattern: const [5, 5],
                  child: Container(
                    height: 170,
                    width: 290,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _selectimage.value== null
                        ? const Center(child: Text('No Image Selected'))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectimage.value!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        savestaff();
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      File selectedFile = File(file.path!);
      Directory direc = await getApplicationDocumentsDirectory();
      String newPath = '${direc.path}/${file.name}';
      File savedFile = await selectedFile.copy(newPath);
       image.value=savedFile.path;
    }
  }

  Future<void> cameraimage() async {
    final cameraimage = ImagePicker();
    final camera = await cameraimage.pickImage(source: ImageSource.camera);
    if (camera != null) {
        image.value=camera.path;
    }
  }

  Future<void> proofimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      File selectedfile = File(file.path!);
      Directory direc = await getApplicationDocumentsDirectory();
      String newPath = '${direc.path}/${file.name}';
      File savedFile = await selectedfile.copy(newPath);
     _selectimage.value=savedFile;
    }
  }
}
