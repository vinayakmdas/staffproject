import 'dart:io';
import 'dart:typed_data'; // For web file handling
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // To check if it's web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // Path provider won't be needed on the web
import 'package:flutter/services.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/appbaruser.dart';
import 'package:staff/model/domainmodel.dart';
import 'package:staff/service/add_domain_servicepage.dart';
import 'package:staff/service/staff_Data_managing.dart';
import 'package:staff/model/staffmodel.dart';
import 'package:staff/custum/navigator.dart';

class StaffAdd extends StatefulWidget {
  StaffAdd({super.key});

  @override
  State<StaffAdd> createState() => _StaffAddState();
}

class _StaffAddState extends State<StaffAdd> {
  final _formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final userPhoneNumber = TextEditingController();
  final userEmail = TextEditingController();

  List<Domainmodel> _domainList = [];
  String? _selectedDomain;

  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> projectlist = ["Frontend", "Backend"];

  final ValueNotifier<String?> _selectedGender = ValueNotifier<String?>(null);
  final ValueNotifier<Uint8List?> _selectedProofImage = ValueNotifier<Uint8List?>(null); // Updated to Uint8List for web compatibility
  final ValueNotifier<String?> _selectedProject = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _profileImage = ValueNotifier<String?>(null);

  final StaffDatas _staffDatas = StaffDatas();

  @override
  void initState() {
    super.initState();
    firstLoading();
  }

  Future<void> firstLoading() async {
    await fetchDomains();
    await _staffDatas.openbox();
  }

  Future<void> fetchDomains() async {
    DomainBox domainBox = DomainBox();
    await domainBox.openBox();
    _domainList = await domainBox.getDomain();
    setState(() {});
  }

  void saveStaff() {
    if (_formkey.currentState!.validate()) {
      final name = usernameController.text.trim();
      final number = userPhoneNumber.text;
      final email = userEmail.text;
      
      if (_selectedProofImage.value != null &&
          _selectedDomain != null &&
          _selectedGender.value != null &&
          _selectedProject.value != null) {

        StaffModel staffModel = StaffModel(
          username: name,
          phonenumber: number,
          email: email,
          domain: _selectedDomain!,
          gender: _selectedGender.value!,
          image: _profileImage.value ?? '',
          proofimage: _selectedProofImage.value.toString(),
          dropdowntask: _selectedProject.value!,
        );
                print("data is saved ");
        _staffDatas.adddetails(staffModel);
        Navigator.of(context).popUntil((route) => route.isFirst);
        navigatepushreplacement(
          context,
          const ButtonNavigationbar(currentPage: 1),
        );
      }
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
                  // Profile image
                  Stack(
                    children: [
                      ValueListenableBuilder<String?>(
                        valueListenable: _profileImage,
                        builder: (context, value, _) {
                          return CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage: value == null
                                ? null
                                : (kIsWeb
                                    ? NetworkImage(value)
                                    : FileImage(File(value))) as ImageProvider,
                            child: value == null
                                ? const Icon(Icons.person, size: 90)
                                : null,
                          );
                        },
                      ),
                      Positioned(
                        bottom: -8,
                        left: 80,
                        child: IconButton(
                          onPressed: () {
                            showImagePickerOptions(context, pickImage, cameraImage);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 43),

                  // Name field
                  usertextfield(
                    controller: usernameController,
                    lebelname: 'NAME :',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Staff name";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),

                  // Phone number field
                  usertextfield(
                    controller: userPhoneNumber,
                    lebelname: "PHONE NUMBER :",
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),

                  // Email field
                  usertextfield(
                    controller: userEmail,
                    lebelname: "E-MAIL :",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter E-mail";
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),

                  // Domain dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 2),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),

                  // Project dropdown
                  ValueListenableBuilder<String?>(
                    valueListenable: _selectedProject,
                    builder: (context, value, _) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        value: value,
                        hint: const Text("Select Project"),
                        items: projectlist.map((String project) {
                          return DropdownMenuItem<String>(
                            value: project,
                            child: Text(project),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          _selectedProject.value = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a project';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Gender dropdown
                  ValueListenableBuilder<String?>(
                    valueListenable: _selectedGender,
                    builder: (context, value, _) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        value: value,
                        hint: const Text('Select Gender'),
                        onChanged: (String? newValue) {
                          _selectedGender.value = newValue;
                        },
                        items: _genders.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // ID/Proof image upload
                  Column(
                    children: [
                      const Text(
                        "Upload Proof of ID",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 11),
                      ValueListenableBuilder<Uint8List?>(
                        valueListenable: _selectedProofImage,
                        builder: (context, value, _) {
                          return DottedBorder(
                            dashPattern: const [6, 6],
                            color: Colors.grey.shade600,
                            strokeWidth: 2,
                            radius: const Radius.circular(12),
                            child: InkWell(
                              onTap: () {
                                pickProofImage();
                              },
                              child: Container(
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: value != null
                                    ? Image.memory(
                                        value,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Icon(Icons.camera_alt_outlined),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Submit button
                  ElevatedButton(
                    onPressed: () {
                      saveStaff();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickProofImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        Uint8List fileBytes = result.files.first.bytes!;
        _selectedProofImage.value = fileBytes;
      }
    } else {
      final imagePicker = ImagePicker();
      final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        Uint8List fileBytes = await pickedFile.readAsBytes();
        _selectedProofImage.value = fileBytes;
      }
    }
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String fileUrl = result.files.first.name;
        _profileImage.value = fileUrl;
      }
    } else {
      final imagePicker = ImagePicker();
      final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _profileImage.value = pickedFile.path;
      }
    }
  }

  Future<void> cameraImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _profileImage.value = pickedFile.path;
    }
  }
  
  void showImagePickerOptions(BuildContext context, VoidCallback galleryAction, VoidCallback cameraAction) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Pick from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  galleryAction();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  cameraAction();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
  