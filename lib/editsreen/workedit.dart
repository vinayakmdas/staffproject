import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:staff/Domain_model/domain.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textcostom.dart';
import 'package:staff/custum/textfield.dart';
import 'package:staff/model/backend_model.dart';
import 'package:staff/model/project_model.dart';
import 'package:staff/model/staffmodel.dart';
import 'package:staff/model/work_model.dart';
import 'package:staff/pdfview.dart';
import 'package:staff/service/backendDatas.dart';
import 'package:staff/service/project_task_service.dart';
import 'package:staff/service/staff_Data_managing.dart';
import 'package:staff/service/work_Datas.dart';
import 'package:path_provider/path_provider.dart';

class Workedit extends StatefulWidget {
  final WorkModel? work;
  final int index;
  Workedit({super.key, this.work, required this.index});

  @override
  State<Workedit> createState() => _WorkeditState();
}

class _WorkeditState extends State<Workedit> {
  final BackendDatas _backendDatas = BackendDatas();

  final datecontroller = TextEditingController();
  final descritioncontroller = TextEditingController();
  WorkDatas workDatas = WorkDatas();
  final Domaincontroller = TextEditingController();
  String? _selectname;
  List<StaffModel> _staffdrop = [];
  String? _selectDomain;
  final _formkey = GlobalKey<FormState>();

  final ValueNotifier<String?> _projectdrop = ValueNotifier<String?>(null);

  List<ProjectModel> _frontendlist = [];
  List<BackendModel> _backendlist = [];
  final ValueNotifier<File?> _workimage = ValueNotifier<File?>(null);

  List<String> dropdata = [];

  trail() {
    if (_frontendlist
        .any((project) => project.projet == widget.work?.project)) {
      dropdata = _frontendlist.map((project) => project.projet).toList();
    } else {
      dropdata = _backendlist.map((backend) => backend.backend).toList();
    }
  }

  Future<void> staffdata() async {
    StaffDatas staffDatas = StaffDatas();
    valueassign();
    await staffDatas.openbox();
    _staffdrop = await staffDatas.getstaffdetails();
    setState(() {});
  }

  Future<void> Front() async {
    ProjectData projectData = ProjectData();
    await projectData.openBox();
    _frontendlist = await projectData.getprojectdata();
    setState(() {});
  }

  Future<void> Back() async {
    await _backendDatas.openBox();

    _backendlist = await _backendDatas.getbackenddata();
    setState(() {});
  }

  Future alldropdatas() async {
    await staffdata();
    await Front();
    await Back();
    await workDatas.openBox();
    print("dropdata is $dropdata");
    trail();
  }

  void _updateDomain() {
    if (_selectname != null) {
      final staff = _staffdrop.firstWhere(
        (staff) => staff.username == _selectname,
        orElse: () => StaffModel(
          username: '',
          phonenumber: '',
          email: '',
          domain: 'No domain assigned',
          gender: '',
        ),
      );

      setState(() {
        Domaincontroller.text =
            staff.domain.isNotEmpty ? staff.domain : 'No domain assigned';
        _selectDomain =
            staff.domain.isNotEmpty ? staff.domain : 'No domain assigned';
      });
    }
  }

// ===========================================================================================================
  Future<void> saveworks() async {
    final date = datecontroller.text.trim();
    final description = descritioncontroller.text.trim();
    final _image = _workimage.value?.path;

    if (_formkey.currentState!.validate() &&
        _selectname != null &&
        date.isNotEmpty &&
        _selectDomain != null &&
        dropdata.isNotEmpty &&
        _image != null &&
        description.isNotEmpty) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      DateTime calendarDate = dateFormat.parse(date);
      WorkModel workModel = WorkModel(
        staffname: _selectname!,
        domainname: _selectDomain!,
        project: _projectdrop.value!,
        calendarDate: calendarDate,
        fileproperties: _image,
        description: description,
      );
      workDatas.updatevalue( widget.index,workModel);
      Navigator.of(context).popUntil((route) => route.isFirst);
      navigatepushreplacement(
        context,
        const ButtonNavigationbar(currentPage: 2),
      );
    }
  }

  void valueassign() {
    _selectname = widget.work?.staffname;
    Domaincontroller.text = widget.work?.domainname ?? " ";
    _projectdrop.value = widget.work?.project;
    descritioncontroller.text = widget.work?.description ?? '';
    datecontroller.text =
        DateFormat('dd/MM/yyyy').format(widget.work!.calendarDate);
    _workimage.value = File(widget.work!.fileproperties!);
  }

  @override
  void initState() {
    super.initState();
    valueassign();
    alldropdatas().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        foregroundColor: Colors.white,
        title: const Text("EDIT WORk"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                customDropdownField(
                  labelText: "Select Staff",
                  hintText: "Select staff",
                  value: _selectname,
                  items: _staffdrop.map((staff) {
                    return DropdownMenuItem<String>(
                      value: staff.username,
                      child: Text(staff.username),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectname = value;
                      _updateDomain();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Please select staff name ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: Domaincontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " First  select staff name ";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
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
                ValueListenableBuilder<String?>(
                  valueListenable: _projectdrop,
                  builder: (context, value, _) {
                    return DropdownButtonFormField<String>(
                      dropdownColor: const Color.fromARGB(210, 4, 46, 82),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                      hint: const Text(
                        "Select project model",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: dropdata.contains(value) ? value : null,
                      items: dropdata.map((String project) {
                        return DropdownMenuItem<String>(
                          value: project,
                          child: Text(
                            project,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _projectdrop.value = newValue;
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
                calender(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Please select  project type ";
                    }
                    return null;
                  },
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
                  lebelname: "Select Date",
                ),
                const SizedBox(height: 20),
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
                        'Add Attachment',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_workimage.value != null &&
                        _workimage.value!.path.endsWith('.pdf')) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfViewerScreen(pdfFile: _workimage.value!),
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
                      valueListenable: _workimage,
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
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                          );
                        } else if (['jpg', 'jpeg', 'png']
                            .contains(fileExtension)) {
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
                                Text(
                                    'Document File: ${file.uri.pathSegments.last}',
                                    style:
                                        const TextStyle(color: Colors.white)),
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
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Please add description name";
                    }
                    return null;
                  },
                  controller: descritioncontroller,
                  maxLines: 4,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Enter Description",
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: "Description",
                    errorStyle: TextStyle(color: Colors.red),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        saveworks();
                      },
                      child: const Apptext(
                        "Save",
                        Colors: const Color.fromRGBO(22, 38, 52, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  workdetails() {
    showModalBottomSheet(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.only(top: 65),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.camera_enhance_outlined,
                            color: Colors.white,
                          ),
                          TextButton(
                              onPressed: () {
                                cameraimage();
                              },
                              child: const Text(
                                "Camera",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.add_to_drive_rounded,
                            color: Colors.white,
                          ),
                          TextButton(
                              onPressed: () {
                                imagefile();
                              },
                              child: const Text(
                                "Gallery",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                          TextButton(
                              onPressed: () {
                                pdfFile();
                              },
                              child: const Text(
                                "PDF",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
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
      allowedExtensions: ['pdf'], // Limit the file picker to PDFs only
    );

    if (result != null && result.files.single.path != null) {
      _workimage.value = File(result.files.single.path!);
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
    _workimage.value = newfile;
  }
}
