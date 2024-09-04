import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/appbaruser.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/model/domainmodel.dart';
import 'package:staff/model/staffmodel.dart';
import 'package:staff/service/add_domain_servicepage.dart';
import 'package:staff/service/staff_Data_managing.dart';

class StaffAdd extends StatefulWidget {
  StaffAdd({super.key});

  @override
  State<StaffAdd> createState() => _StaffAddState();
}

class _StaffAddState extends State<StaffAdd> {
  final usernameController = TextEditingController();
  final userPhoneNumber = TextEditingController();
  final userEmail = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  ValueNotifier<String?> image = ValueNotifier<String?>(null);
  List<Domainmodel> _domainList = [];
  String? _selectedDomain;
  final List<String> _genter = ["Male", "Female", "Other"];
  final ValueNotifier<String?> _selectgenter = ValueNotifier<String?>(null);
  final ValueNotifier<File?> _selectimage = ValueNotifier<File?>(null);
  final ValueNotifier<String?> _projeccontroller = ValueNotifier<String?>(null);

  final StaffDatas _staffDatas = StaffDatas();
  final List<String> projectlist = ["Frontend", "Backend"];

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
    setState(() {});
  }

  void savestaff() {
    final proofImagePath = _selectimage.value?.path;
    final name = usernameController.text.trim();
    final number = userPhoneNumber.text;
    final email = userEmail.text;
    if (_formkey.currentState!.validate() &&
        name.isNotEmpty &&
        number.isNotEmpty &&
        email.isNotEmpty &&
        _projeccontroller.value != null &&
        _selectgenter.value != null &&
        _selectedDomain != null &&
        proofImagePath != null) {
      StaffModel staffModel = StaffModel(
          username: name,
          phonenumber: number,
          email: email,
          domain: _selectedDomain!,
          gender: _selectgenter.value.toString(),
          image: image.value.toString(),
          proofimage: proofImagePath,
          dropdowntask: _projeccontroller.value.toString());

      _staffDatas.adddetails(staffModel);
      print(" save staff project data is : ${staffModel.dropdowntask}");
      print("save staff datas ");
      Navigator.of(context).popUntil((route) => route.isFirst);
      navigatepushreplacement(
        context,
        const ButtonNavigationbar(currentPage: 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      appBar: userappbar(context, "ADD STAFF"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(23),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ValueListenableBuilder<String?>(
                        valueListenable: image,
                        builder: (context, value, _) {
                          return CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                value == null ? null : FileImage(File(value)),
                            child: value == null
                                ? const Icon(
                                    Icons.person,
                                    size: 90,
                                  )
                                : null,
                          );
                        },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Please enter Staff name";
                      }
                      return null;
                    },
                    controller: usernameController,
                    lebelname: 'NAME  :',
                  ),
                  const SizedBox(height: 20),
                  usertextfield(
                    controller: userPhoneNumber,
                    lebelname: "PHONE NUMBER  :",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Phone number";
                      } else if (value.length != 10) {
                        return 'Please enter a valid Mobile number';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
                  const SizedBox(height: 20),
                  usertextfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter E mail";
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: userEmail,
                    lebelname: "E-MAIL  :",
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 2))),
                    value: _selectedDomain,
                    hint: const Text('Select Domain'),
                    onChanged: (value) {
                      setState(() {
                        _selectedDomain = value;
                      });
                    },
                    items: _domainList.map((domain) {
                      return DropdownMenuItem<String>(
                        value: domain.domain,
                        child: Text(domain.domain),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a domain';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                    ValueListenableBuilder<String?>(
                      valueListenable: _projeccontroller,
                      builder: (context, value, _) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 1),
                            ),
                          ),
                          hint: const Text(
                            "Select project model",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: projectlist.contains(value) ? value : null,
                          items: projectlist.map((String project) {
                            return DropdownMenuItem<String>(
                              value: project,
                              child: Text(project),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            _projeccontroller.value = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Project Type';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<String?>(
                    valueListenable: _selectgenter,
                    builder: (context, value, _) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(width: 1))),
                        hint: const Text(
                          "Select Gender",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: value,
                        items: _genter.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          _selectgenter.value = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      );
                    },
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
                      child: ValueListenableBuilder<File?>(
                        valueListenable: _selectimage,
                        builder: (context, file, _) {
                          return file == null
                              ? const Center(child: Text('No Image Selected'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                  ),
                                );
                        },
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
      ),
    );
  }

  void pickimage() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();
    if (file != null) {
      image.value = file.files.single.path!;
    }
  }

  void cameraimage() async {
    XFile? imagefile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (imagefile == null) return;
    Directory dir = await getApplicationDocumentsDirectory();
    File temp = File(imagefile.path);
    File newfile = await temp.copy('${dir.path}/${imagefile.name}');
    image.value = newfile.path;
  }

  void proofimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectimage.value = File(result.files.single.path!);
    }
  }
}
