import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/custum/dashboarditem.dart';

import 'package:staff/custum/navigator.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';


class Settings extends StatelessWidget {

   Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
   navigatpushremoveuntil(context, Loginpage());
  }
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor:   const Color.fromRGBO(22, 38, 52, 1), 
         appBar: AppBar(
          backgroundColor:   const Color.fromRGBO(22, 38, 52, 1),
          title: const Text("STAGE",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: const IconThemeData(color:  Colors.white),         ),
           endDrawer: Drawer(
            
       
       backgroundColor: Colors.transparent,
       child: Container(
         decoration: BoxDecoration(
         color:const Color.fromARGB(90, 42, 50, 57).withOpacity(0.4),
            borderRadius :const BorderRadius.only(bottomRight:Radius.circular(370))
         )
        , child: Padding(
          padding: const EdgeInsets.only(top: 179),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.report,color: Colors.white,),
                    title: const Text('About us ',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      
                    }
                     
              ),ListTile(
                leading: const Icon(Icons.security_outlined,color: Colors.white,),
                    title: const Text('Privacy and policy',style: TextStyle(color: Colors.white)),
                    onTap: () {
                      
                    }
                     
              ),
              ListTile(
                leading: const Icon(Icons.note_sharp,color: Colors.white,),
                    title: const Text('Terms and condition ',style: TextStyle(color: Colors.white)),
                    onTap: () {
                      
                    }
                     
              ), 
              ListTile(
                leading: const Icon(Icons.connect_without_contact_outlined,color: Colors.white,),
                    title: const Text(' contact Us ',style: TextStyle(color: Colors.white)),
                    onTap: () {
                      
                    }
                     
              ),
              ListTile(
                leading: const Icon(Icons.logout,color: Colors.red,),
                    title: const Text(' Log Out ',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    onTap: () {
                       showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                     backgroundColor:   const Color.fromRGBO(22, 38, 52, 1), 
                      title: const Text('Log out',style: TextStyle(color: Colors.white),),
                      content: const Text('Are you sure want to delete',style: TextStyle(color: Colors.white),),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text('Cancel')),
                        ElevatedButton(onPressed: (){
                         _logout(context);
                         
                        }, child: const Text('OK'))
                      ],
                    );
                  });
                    }
                     
              ),
            ],
          ),
        ),
         
       )
     ),

    body:  Padding(
      padding: const EdgeInsets.only(left: 25,right: 25,top: 30),
      child: Column(
         children: [
                DashboardItemWidget(onTap1: 
                (){}, onTap2: (){}, titleOne: "Pending", titleTwo: "Complete")
               , SizedBox(height: 20,)
               , Divider(color:Colors.orange ,)
         ],
      ),
    ) ,


    );
  }
}