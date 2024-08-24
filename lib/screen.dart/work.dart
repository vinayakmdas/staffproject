import 'package:flutter/material.dart';
import 'package:staff/screen.dart/completework.dart';
import 'package:staff/screen.dart/pending.dart';



class AllWork extends StatelessWidget {
  const AllWork({super.key});

  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: 2,
      child: Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        foregroundColor: Colors.white,
        title: const Text("WORK DETAILS"),
        centerTitle: true,
      ),
        body:   Column(
          children: [
            Container(
              color:  const Color.fromRGBO(22, 38, 52, 1),
              child: const TabBar(  
                  
                   indicatorColor: Colors.white,
                    unselectedLabelStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                tabs: [
                       Tab(
                text: "Pending",
              
                      )
                        ,Tab(
                text: "Complete",
              
                      )
              ]
                
              
              ),
            )
            , 
            
          Expanded(
            child: TabBarView(children: [
                  WorkScreen(),
                  CompleteScreen(),
            ]),
          )
          ],
        ),
      ),
    );
  }
}