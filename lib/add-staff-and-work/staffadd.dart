  import 'dart:io';

import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:staff/custum.dart/appbaruser.dart';

  class StaffAdd extends StatefulWidget {

  

    StaffAdd({super.key});

    @override
    State<StaffAdd> createState() => _StaffAddState();
  }

  class _StaffAddState extends State<StaffAdd> {
    final usernameController = TextEditingController();

    final userPhoneNumber = TextEditingController();

    final userEmail = TextEditingController();
  String ?image;
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
                             Showimageplace(context, pickimage,camereimage);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Color.fromARGB(255, 30, 4, 4),
                                size: 40,
                              )),
                          bottom: -8,
                          left: 80,
                        )
                      ]
                  ),
                  const SizedBox(height: 43),
                  usertextfield(controller: usernameController, lebelname: 'NAME  :',),
                  const SizedBox(height: 20),
                usertextfield(controller: userPhoneNumber, lebelname: "PHONE NUMBER  :")
                  ,const SizedBox(height: 20),
                  usertextfield(controller: userEmail, lebelname: "E-MAIL  :")
                  
                ],
              ),
            ),
          ),
        ),
      );

      
    }
    pickimage()async{
    final imagePicker =ImagePicker();
    final pickedimg = await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedimg!=null){setState(() {
      image=pickedimg.path;
    });

  }
  }

    Future camereimage()async{
      final  camereimage=ImagePicker();
      final camere = await camereimage.pickImage(source: ImageSource.camera);
        if(camere!=null){setState(() {
      image=camere.path;
    });

  }
    }
  }
