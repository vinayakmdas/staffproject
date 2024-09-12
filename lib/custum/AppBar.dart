import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomAppBar extends StatelessWidget {
  final Text? title;
  final Widget? leading;
  final Widget? trailing;

  const CustomAppBar({super.key, this.title, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 87,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(22, 38, 52, 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
             
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 33),
              child: Row(
                children: [
                  leading ?? SizedBox(width: 50), 
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: title
                       
                      ?? Text(
                        "Title",
                        style: GoogleFonts.getFont('Lato', color: Colors.white, fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  trailing ??SizedBox(width: 50), 
                ],
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}



// ==============================================================================================================================






class containerhomescreen extends StatelessWidget {
  final String  heading;
  final IconData icons;
  final Color   color;
  final int  count;
  const containerhomescreen({super.key,
   required this.count,
  required this.icons,
  required this.heading
  ,required this.color

  });

  @override
  Widget build(BuildContext context) {
    return  
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 23, right: 23),
          child: Container(  height: 200,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Icon(icons, size: 43, color: color),
                      const SizedBox(height: 15),
                      Text( heading, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                      Text( count.toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              
          
          ),
        )
      ],


    );

  }
}

