import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff/taskadd/backend.dart';
import 'package:staff/taskadd/domain.dart';
import 'package:staff/taskadd/frontend.dart';

class TaskPage extends StatelessWidget {
  const TaskPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Padding(
          padding:  EdgeInsets.only(left: 72),
          child: Text("ADD ITEMS", style: GoogleFonts. getFont('Lato'),),
          
        ),
      ), 
    body: ListView(
        children: [
          ListTile(
          title: Text(
            " ADD DOMAIN",
            style: GoogleFonts.getFont('Lato',
                color: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.black,
            
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Domain()));
          },
          
        ),
        const Divider()
        ,ListTile(
          title: Text(
            " ADD FRONTEND",
            style: GoogleFonts.getFont('Lato',
                color: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.black,
            
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Frontend()));
          },
          
        )
        ,const Divider()
        ,ListTile(
          title: Text(
            " ADD BACKEND",
            style: GoogleFonts.getFont('Lato',
                color: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.black,
            
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Backend()));
          },
          
        )
        ],
        
      ),
    
      
    );
  }
}