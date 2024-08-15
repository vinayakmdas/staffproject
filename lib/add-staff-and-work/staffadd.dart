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
import 'package:staff/screen.dart/staffscreen.dart';
import 'package:staff/service.dart/add_domain_servicepage.dart';
import 'package:staff/service.dart/staff_Data_managing.dart';

class StaffAdd extends StatefulWidget {
  StaffAdd({super.key});

  @override
  State<StaffAdd> createState() => _StaffAddState();
}

class _StaffAddState extends State<StaffAdd> {
    final usernameController = TextEditingController();
    final userPhoneNumber = TextEditingController();
    final userEmail = TextEditingController();

    String? image;
    List<Domainmodel> _domainList = [];
    String? _selectedDomain;
    List<String> _genter = ["Male", "Female", "Other"];
    String? _selectgenter;
    File? _selectimage;

  StaffDatas _staffDatas = StaffDatas();

  @override
  void initState() {
    super.initState();
    firstloading();
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
      _selectedDomain = _domainList.first.domain; // Set default selected value
    }
    setState(() {});
  }

  void savestaff() {
    final proofImagePath = _selectimage?.path;
    final name = usernameController.text.trim();
    final number = userPhoneNumber.text;
    final email = userEmail.text;

    if (name.isNotEmpty &&
        number.isNotEmpty &&
        email.isNotEmpty &&
        _selectgenter != null &&
        _selectedDomain != null &&
        proofImagePath != null) {

      StaffModel staffModel = StaffModel(
        username: name,
        phonenumber: number,
        email: email,
        domain: _selectedDomain!,
        gender: _selectgenter!,
        image: image,
        proofimage: _selectimage?.path,
      );

      _staffDatas.adddetails(staffModel);
    Navigator.of(context).popUntil((route) => route.isFirst);
    navigatepushreplacement(context, ButtonNavigationbar(currentPage: 1,));
    }
  }




   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
      appBar: userappbar(context,"ADD STAFF"),
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
                    image == null
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
                            backgroundImage: FileImage(File(image!)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: DropdownButton<String>(
                      iconEnabledColor: Colors.black,
                      hint: const Text(
                        "Select Domain",
                        style: TextStyle(color: Colors.black),
                      ),
                      value: _selectedDomain,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDomain = newValue;
                        });
                      },
                      items: _domainList
                          .map<DropdownMenuItem<String>>((Domainmodel domain) {
                        return DropdownMenuItem<String>(
                          value: domain.domain,
                          child: Text(domain.domain),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 123,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 32, 58, 81),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: const Text("Gender"),
                          iconEnabledColor: Colors.black,
                          value: _selectgenter,
                          items: _genter.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectgenter = newValue;
                            });
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
                    child: _selectimage == null
                        ? const Center(child: Text('No Image Selected'))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectimage!,
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
      setState(() {
        image = savedFile.path;
      });
    } else {
      print("User canceled the file picker");
    }
  }

  Future<void> cameraimage() async {
    final cameraimage = ImagePicker();
    final camera = await cameraimage.pickImage(source: ImageSource.camera);
    if (camera != null) {
      setState(() {
        image = camera.path;
      });
    }
  }

  Future<void> proofimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      File selectedFile = File(file.path!);
      Directory directory = await getApplicationDocumentsDirectory();
      String newPath = '${directory.path}/${file.name}';
      File savedFile = await selectedFile.copy(newPath);
      setState(() {
        _selectimage = savedFile;
      });
    }
  }
}