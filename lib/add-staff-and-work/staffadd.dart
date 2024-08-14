import 'dart:io';
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
  List<String>_genter=[" male ", "female"];
  String ?_selectgenter;

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
              children: <Widget>[
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
             UserTextField(
  controller: usernameController,
  labelName: 'NAME:',
),
const SizedBox(height: 20),
UserTextField(
  controller: userPhoneNumber,
  labelName: 'PHONE NUMBER:',
),
const SizedBox(height: 20),
UserTextField(
  controller: userEmail,
  labelName: 'E-MAIL:',
),
const SizedBox(height: 20),
                
             
                Container(
                  height: 50,
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:  Border.all(
                       width: 2,
                        color: Color.fromARGB(255, 32, 58, 81)
                        
                    )
                    ,borderRadius: BorderRadius.circular(12)
                   
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: DropdownButton<String>(
                      
                      iconEnabledColor: Colors.black,                   
                      hint: Text("Select Domain",style:TextStyle( color: Colors.black),),
                      value: _selectedDomain, 
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDomain = newValue; 
                        });
                      },
                      items: _domainList.map<DropdownMenuItem<String>>((Domainmodel domain) {
                        return DropdownMenuItem<String>(
                          value: domain.domain,
                          child: Text(domain.domain),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: 20,)
                // ==========================================================================        

               ,Container(
                 height: 50,
                  width: 123,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:  Border.all(
                       width: 2,
                        color: Color.fromARGB(255, 32, 58, 81)
                        
                    )
                    ,borderRadius: BorderRadius.circular(12)
  ),
   child: Row(
     children: [
               

       Padding(
         padding: const EdgeInsets.all(8.0),
         child: DropdownButton<String>(
          hint: Text("Genter"),
          iconEnabledColor: Colors.black,
          value: _selectgenter,
          items: _genter.map((String genter) {
            return DropdownMenuItem<String>(
              value: genter, // Add the value here
              child: Text(genter), // Show the gender text here
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectgenter = newValue; // Update selected gender
            });
          },
         ),
       ),
     ],
   ),
 )


              ],
            ),
          ),
        ),
      ),
    );
  }


  pickimage() async {
    final imagePicker = ImagePicker();
    final pickedimg = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedimg != null) {
      setState(() {
        image = pickedimg.path; 
      });
    }
  }

  // Method to take a photo using the camera
  Future camereimage() async {
    final camereimage = ImagePicker();
    final camere = await camereimage.pickImage(source: ImageSource.camera);
    if (camere != null) {
      setState(() {
        image = camere.path; // Update image path
      });
    }
  }
}
