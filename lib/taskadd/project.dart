import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class projecttask extends StatefulWidget {
  const projecttask({super.key});

  @override
  State<projecttask> createState() => _projecttaskState();
}
final projecttext=TextEditingController();
class _projecttaskState extends State<projecttask> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 72),
          child: Text("PROJECT", style: GoogleFonts. getFont('Lato'),),
        ),
      ), 

      floatingActionButton: FloatingActionButton(onPressed: 
      (){
           showdiologproject();
      } ,backgroundColor: const Color.fromRGBO(22, 38, 52, 1), child:  const Icon(Icons.add,color: Colors.white,),),
    );
    
  }

   Future  showdiologproject()async{
    await showDialog(context: context , builder: (context){

    
    return 
           AlertDialog(
       backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      content:  Container(
        height: 212,
        
        
        child:  Column(
          children: [

             const Row(
              children: [
                Text("Enter project ",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
              ],
             ),
             const SizedBox(height: 23,)
               , TextField(
                    controller: projecttext,
                    style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                    decoration: InputDecoration( 
                      fillColor: Colors.grey,
                       filled: true
                      , border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), 
                      )
                    ),
                )
                ,SizedBox(height: 35,)
               ,  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                             ElevatedButton(onPressed: (){}, child: Text("Submit",style: TextStyle(color:const Color.fromRGBO(22, 38, 52, 1) ) ,))
                  ],
                )
          ],
        ),
      ),
    );
    }
    );
  
  }
}