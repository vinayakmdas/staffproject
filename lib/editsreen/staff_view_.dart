import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import this for kIsWeb
import 'package:staff/model/staffmodel.dart';
import 'dart:convert'; // For base64 encoding
import 'dart:typed_data'; // For handling byte data

class ViewStaff extends StatelessWidget {
  final StaffModel staff;
  const ViewStaff({super.key, required this.staff});

  // Convert File to Base64 string
  Future<String?> convertImageToBase64(String filePath) async {
    try {
      final bytes = await File(filePath).readAsBytes(); // Read file as bytes
      return base64Encode(bytes); // Encode to Base64
    } catch (e) {
      return null; // Handle any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Details'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 251.0,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<String?>(
                future: kIsWeb && staff.image != null
                    ? convertImageToBase64(staff.image!)
                    : Future.value(null),
                builder: (context, snapshot) {
                  if (snapshot.hasData && kIsWeb) {
                    // Display base64 image for web
                    Uint8List imageBytes = base64Decode(snapshot.data!);
                    return Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                    );
                  } else if (staff.image != null) {
                    return !kIsWeb
                        ? Image.file(
                            File(staff.image!),
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Text('Loading Image...'),
                          );
                  } else {
                    return Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text('No Image Available'),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: const Color.fromRGBO(22, 38, 52, 1),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Name               :',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            Text("       ${staff.username}",
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Domain            :',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            Text("       ${staff.domain}",
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Email                :',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            Text("       ${staff.email}",
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Project type     :',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            Text("       ${staff.dropdowntask}",
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Contact            :',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            Text("       ${staff.phonenumber}",
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Gender             :',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                            Text("       ${staff.gender}",
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Center(
                          child: Text(
                            "ID PROOF",
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        staff.proofimage != null
                            ? FutureBuilder<String?>(
                                future: kIsWeb && staff.proofimage != null
                                    ? convertImageToBase64(staff.proofimage!)
                                    : Future.value(null),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData && kIsWeb) {
                                    Uint8List imageBytes = base64Decode(snapshot.data!);
                                    return Image.memory(
                                      imageBytes,
                                      height: 202,
                                    );
                                  } else if (!kIsWeb) {
                                    return Image.file(
                                      File(staff.proofimage!),
                                      height: 202,
                                    );
                                  } else {
                                    return const Center(
                                      child: Text('No Proof Image Available'),
                                    );
                                  }
                                },
                              )
                            : Container(
                                color: Colors.grey,
                                height: 200,
                                width: double.infinity,
                                child: const Center(
                                  child: Text('No Proof Image Available'),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
