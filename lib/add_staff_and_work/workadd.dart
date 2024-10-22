import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb; // Import for platform check
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:staff/Domain_model/domain.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/model/backend_model.dart';
import 'package:staff/model/project_model.dart';
import 'package:staff/model/staffmodel.dart';
import 'package:staff/model/work_model.dart';
import 'package:staff/service/backendDatas.dart';
import 'package:staff/service/project_task_service.dart';
import 'package:staff/service/staff_Data_managing.dart';
import 'package:staff/service/work_Datas.dart';

class Workadd extends StatefulWidget {
  const Workadd({super.key});

  @override
  State<Workadd> createState() => _WorkaddState();
}

class _WorkaddState extends State<Workadd> {
  final BackendDatas _backendDatas = BackendDatas();
  final datecontroller = TextEditingController();
  final descriptionController = TextEditingController();
  final domainController = TextEditingController();

  WorkDatas workDatas = WorkDatas();
  String? _selectName;
  List<StaffModel> _staffDrop = [];
  String? _selectDomain;
  final _formKey = GlobalKey<FormState>();
  String? _projectDrop;

  List<ProjectModel> _frontendList = [];
  List<BackendModel> _backendList = [];
  File? _selectedImage; // Store selected image here
  List<String> dropdata = [];
  final ImagePicker _imagePicker = ImagePicker(); // Create ImagePicker instance

  @override
  void initState() {
    super.initState();
    alldropdatas();
  }

  Future<void> staffdata() async {
    StaffDatas staffDatas = StaffDatas();
    await staffDatas.openbox();
    _staffDrop = await staffDatas.getstaffdetails();
    setState(() {});
  }

  Future<void> Front() async {
    ProjectData projectData = ProjectData();
    await projectData.openBox();
    _frontendList = await projectData.getprojectdata();
    setState(() {});
  }

  Future<void> Back() async {
    await _backendDatas.openBox();
    _backendList = await _backendDatas.getbackenddata();
    setState(() {});
  }

  Future<void> alldropdatas() async {
    await staffdata();
    await Front();
    await Back();
    await workDatas.openBox();
  }

  void _updateDomain() {
    if (_selectName != null) {
      final staff = _staffDrop.firstWhere(
        (staff) => staff.username == _selectName,
        orElse: () => StaffModel(
          username: '',
          phonenumber: '',
          email: '',
          domain: 'No domain assigned',
          gender: '',
        ),
      );

      setState(() {
        domainController.text = staff.domain.isNotEmpty ? staff.domain : 'No domain assigned';
        _selectDomain = staff.domain.isNotEmpty ? staff.domain : 'No domain assigned';

        final dropdowntaskValue = staff.dropdowntask is ValueNotifier<String?>
            ? (staff.dropdowntask as ValueNotifier<String?>).value
            : staff.dropdowntask;

        if (dropdowntaskValue == "Frontend") {
          dropdata = _frontendList.map((project) => project.projet).toList();
        } else if (dropdowntaskValue == "Backend") {
          dropdata = _backendList.map((backend) => backend.backend).toList();
        } else {
          dropdata = ['No projects available'];
        }
      });
    }
  }

  Future<void> saveworks() async {
    final date = datecontroller.text.trim();
    final description = descriptionController.text.trim();
    final imagePath = _selectedImage?.path;

    if (_formKey.currentState!.validate() &&
        _selectName != null &&
        date.isNotEmpty &&
        _selectDomain != null &&
        _projectDrop != null &&
        imagePath != null &&
        description.isNotEmpty) {

      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      DateTime calendarDate = dateFormat.parse(date);
      WorkModel workModel = WorkModel(
        staffname: _selectName!,
        domainname: _selectDomain!,
        project: _projectDrop!,
        calendarDate: calendarDate,
        fileproperties: imagePath,
        description: description,
      );

      workDatas.addwork(workModel);
      Navigator.of(context).popUntil((route) => route.isFirst);
      navigatepushreplacement(
        context,
        const ButtonNavigationbar(currentPage: 2),
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        datecontroller.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Set the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        foregroundColor: Colors.white,
        title: const Text("ADD WORK"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                customDropdownField(
                  labelText: "Select Staff",
                  hintText: "Select staff",
                  value: _selectName,
                  
                  items: _staffDrop.map((staff) {
                    return DropdownMenuItem<String>(
                      value: staff.username,
                    
                      child: Text(staff.username,style: TextStyle(color: Colors.white),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectName = value;
                      _updateDomain(); 
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select staff name";
                    }
                    return null;
                  },
                  
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: domainController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "First select staff name";
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: "Select Domain",
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                customDropdownField(
                  
                  labelText: "Select Project",
                  hintText: "Select Project",
                  value: _projectDrop,
                
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select project type";
                    }
                    return null;
                  },
                  
                  items: dropdata.map((drop) {
                    return DropdownMenuItem<String>(
                      value: drop.toString(),
                      child: Text(drop.toString(),style: TextStyle(color: Colors.white),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _projectDrop = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _selectDate();
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: datecontroller,
                                 
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please select a date";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: _selectedImage != null // Display selected image
                        ? (kIsWeb 
                            ? Image.network(
                                _selectedImage!.path, // Placeholder, update if needed
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                          )
                        : Center(
                            child: Text(
                              "Pick an image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  style: TextStyle(color: Colors.white),
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: "Description",
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveworks,
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customDropdownField({
    required String labelText,
    required String hintText,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dropdownColor: Colors.grey[800],
    );
  }
}
