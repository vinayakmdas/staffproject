import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/appbaruser.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/model/domainmodel.dart';
import 'package:staff/model/staffmodel.dart';
import 'package:staff/service/add_domain_servicepage.dart';
import 'package:staff/service/staff_Data_managing.dart';

class EditStaff extends StatefulWidget {
  final StaffModel staff;
  final int index;

  EditStaff({super.key, required this.staff, required this.index});

  @override
  State<EditStaff> createState() => _EditStaff();
}

class _EditStaff extends State<EditStaff> {
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
  ValueNotifier<String?> _projeccontroller = ValueNotifier<String?>(null);
  final StaffDatas _staffDatas = StaffDatas();
  final List<String> projectlist = ["Frontend", "Backend"];

  savestaff() {
    final proofImagePath = _selectimage.value?.path;
    final name = usernameController.text.trim();
    final number = userPhoneNumber.text;
    final email = userEmail.text;

    if (_formkey.currentState!.validate() &&
        proofImagePath != null &&
        name.isNotEmpty &&
        _projeccontroller.value != null &&
        number.isNotEmpty &&
        email.isNotEmpty &&
        _selectedDomain != null &&
        _genter.isNotEmpty &&
        image.value != null) {
      StaffModel staffModel = StaffModel(
        username: name,
        phonenumber: number,
        email: email,
        domain: _selectedDomain!,
        gender: _selectgenter.value!,
        image: image.value,
        proofimage: _selectimage.value?.path,
        dropdowntask: _projeccontroller.value.toString(),
      );
      _staffDatas.updatevalue(widget.index, staffModel);
      Navigator.of(context).popUntil((route) => route.isFirst);
      navigatepushreplacement(
        context,
        ButtonNavigationbar(
          currentPage: 1,
        ),
      );
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
      _selectedDomain = _domainList.first.domain;
    }
    setState(() {});
  }

  void connectdatas() {
    usernameController.text = widget.staff.username;
    userPhoneNumber.text = widget.staff.phonenumber;
    userEmail.text = widget.staff.email;
    image.value = widget.staff.image;
    _selectgenter.value = widget.staff.gender;
    _selectedDomain = widget.staff.domain;
    _projeccontroller.value = widget.staff.dropdowntask;
    _selectimage.value = widget.staff.proofimage != null ? File(widget.staff.proofimage!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
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
            child: Form(
              key: _formkey,
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
                          : kIsWeb
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(image.value!),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Please enter Staff name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  usertextfield(
                    controller: userPhoneNumber,
                    lebelname: "PHONE NUMBER  :",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Phone number";
                      } else if (value.length != 10) {
                        return 'Please enter a valid Mobile number';
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
                  const SizedBox(height: 20),
                  usertextfield(
                    controller: userEmail,
                    lebelname: "E-MAIL  :",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter E mail";
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'Please enter a valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(width: 2),
                      ),
                    ),
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
                  const SizedBox(height: 20),
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
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
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
                            return 'Please select a Gender';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: savestaff,
                      child: const Text("Save Staff"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to show image picker options
  void Showimageplace(BuildContext context, Function pickImage, Function cameraImage) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  cameraImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to pick an image from the gallery
  Future<void> pickimage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // For web
      if (kIsWeb) {
        // Convert picked file to a URL if required
        image.value = pickedFile.path; // Replace with your URL logic
      } else {
        _selectimage.value = File(pickedFile.path);
        image.value = pickedFile.path;
      }
    }
  }

  // Function to capture an image using the camera
  Future<void> cameraimage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // For web
      if (kIsWeb) {
        // Convert picked file to a URL if required
        image.value = pickedFile.path; // Replace with your URL logic
      } else {
        _selectimage.value = File(pickedFile.path);
        image.value = pickedFile.path;
      }
    }
  }
}
