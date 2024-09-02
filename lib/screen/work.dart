import 'package:flutter/material.dart';
import 'package:staff/screen/completework.dart';
import 'package:staff/screen/pending.dart';



class allwork extends StatelessWidget {
  const allwork({super.key});

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
                  Completework(),
            ]),
          )
          ],
        ),
      ),
    );
  }
}