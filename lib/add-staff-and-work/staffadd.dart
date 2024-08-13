import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staff/custum.dart/appbaruser.dart';
import 'package:staff/model.dart/domainmodel.dart';
import 'package:staff/service.dart/add_domain_servicepage.dart';

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
  List<String> _genter = [" male ", "Female"," Other"];
  String? _selectgenter;
File ?_selectimage;

  @override
  void initState() {
    super.initState();
    fetchDomains();
  }

  Future<void> fetchDomains() async {
    DomainBox domainBox = DomainBox();
    await domainBox.openBox();
    _domainList = await domainBox.getDomain();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: userappbar(context),
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
                                )),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(image!)),
                          ),
                    Positioned(
                      child: IconButton(
                          onPressed: () {
                            Showimageplace(context, pickimage, camereimage);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Color.fromARGB(255, 30, 4, 4),
                            size: 40,
                          )),
                      bottom: -8,
                      left: 80,
                    )
                  ],
                ),
                const SizedBox(height: 43),
                usertextfield(
                  controller: usernameController,
                  lebelname: 'NAME  :',
                ),
                const SizedBox(height: 20),
                usertextfield(
                    controller: userPhoneNumber, lebelname: "PHONE NUMBER  :"),
                const SizedBox(height: 20),
                usertextfield(controller: userEmail, lebelname: "E-MAIL  :"),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 330,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 2, color: Color.fromARGB(255, 32, 58, 81)),
                      borderRadius: BorderRadius.circular(12)),
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
                const SizedBox(
                  height: 20,
                )
                // ==========================================================================

                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 123,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 2, color: Color.fromARGB(255, 32, 58, 81)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: const Text("Genter"),
                          iconEnabledColor: Colors.black,
                          value: _selectgenter,
                          items: _genter.map((String genter) {
                            return DropdownMenuItem<String>(
                              value: genter,
                              child: Text(genter),
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
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {proofimage();},
                    child: const Text(
                      "Upload proof",
                      style: TextStyle(fontSize: 21),
                    )),
                const SizedBox(
                  height: 20,
                ),
                DottedBorder(
                  color: Colors.blueAccent,
                  strokeWidth: 2,
                  dashPattern: const [
                    5,
                    5,
                  ],
                  child: Container(
                    height: 170,
                    width: 290,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: _selectimage == null
              ? const Center(child: 
              Text('No Image Selected'))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectimage!,
                    fit: BoxFit.cover,
                  ),
                ),
                  ),
                )
               , SizedBox(height: 20,)
               , Row(
                  children: [
ElevatedButton(        
                         style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
                            shape: RoundedRectangleBorder(
                              
                                borderRadius: BorderRadius.circular(8))),
                                
  onPressed: (){}, child: Text("Submit",style: TextStyle( color: Colors.white),))                  ],
                )
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

      print('File saved at: $image');
    } else {
      print("User canceled the file picker");
    }
  }

  Future camereimage() async {
    final camereimage = ImagePicker();
    final camere = await camereimage.pickImage(source: ImageSource.camera);
    if (camere != null) {
      setState(() {
        image = camere.path;
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
        _selectimage= savedFile;
      });
    }
  }
}
