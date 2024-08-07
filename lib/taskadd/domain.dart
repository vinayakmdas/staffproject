import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Domain extends StatefulWidget {
  const Domain({super.key});

  @override
  State<Domain> createState() => _DomainState();
}
 final  domaintext=TextEditingController();
class _DomainState extends State<Domain> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 72),
          child: Text("DOMAIN", style: GoogleFonts. getFont('Lato'),),
        ),
      ), 

      floatingActionButton: FloatingActionButton(onPressed: 
      (){
           showdiolog();
      } ,backgroundColor: const Color.fromRGBO(22, 38, 52, 1), child:  const Icon(Icons.add,color: Colors.white,),),
    );
  }

  Future  showdiolog()async{
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
                Text("Enter Domain name",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
              ],
             ),
             const SizedBox(height: 23,)
               , TextField(
                    controller: domaintext,
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