import 'dart:io';
import 'package:flutter/material.dart';
import 'package:staff/model/staffmodel.dart';

class ViewStaff extends StatelessWidget {
  final StaffModel staff;
  const ViewStaff({super.key, required this.staff});

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
              background: staff.image != null
                  ? Image.file(
                      File(staff.image!),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text('No Image Available'),
                      ),
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color:  const Color.fromRGBO(22, 38, 52, 1),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Name               :',
                                style: TextStyle(fontSize: 18,color: Colors.white)),
                            Text("${staff.username}",style: const TextStyle(color: Colors.white),)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Domain            :',
                                style: TextStyle(fontSize: 18,color: Colors.white)),
                            Text("       ${staff.domain}",style: const TextStyle(color: Colors.white),)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Email                :',
                                style: TextStyle(fontSize: 18,color: Colors.white)),
                            Text("       ${staff.email}",style: const  TextStyle(color: Colors.white),)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Contact            :',
                                style: TextStyle(fontSize: 18,color: Colors.white)),
                            Text("       ${staff.phonenumber}",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Gender             :',
                                style: TextStyle(fontSize: 18,color: Colors.white)),
                            Text("       ${staff.gender}",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                            child: Text(
                          "ID PROOF",
                          style: TextStyle(fontSize: 23,color: Colors.white),
                        )),
                        const SizedBox(height: 20,)
                        ,staff.proofimage != null
                            ? Center(
                                child: Image.file(
                                  (File(staff.proofimage!)),
                                  height: 202,
                                ),
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
