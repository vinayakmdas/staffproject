import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


PreferredSize userappbar(BuildContext context,names) {
  return PreferredSize(
    preferredSize: Size.fromHeight(150.0), // Adjusted to a fixed height
    child: Stack(
      children: <Widget>[
     
        Container(
          width: MediaQuery.of(context).size.width,
          height: 131.0, 
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(66.0), 
              bottomRight: Radius.circular(66.0),
            ),
          ),
          child:  Center(
            child: Text(
              names,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color:  const Color.fromRGBO(22, 38, 52, 1),
          ),
              ),
            ), 
        ),
   
      ],
    ),
  );
}


class usertextfield extends StatelessWidget {
   final  TextEditingController  controller;
final    List<TextInputFormatter>?inputFormatters;
    final String lebelname;
     final String? Function(String?)? validator;
      final AutovalidateMode ?autovalidateMode;
  const usertextfield({super.key
   ,required this.controller
   
   , required this.lebelname
   ,this.autovalidateMode
   ,this.validator
   ,this.inputFormatters
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: controller,
         decoration: InputDecoration(
                        label:  Text(
                       lebelname,
                       
                        style: const TextStyle(
                          
                        color: Color.fromARGB(255, 22, 42, 77)),
                        
                        ),
                       border: OutlineInputBorder(
 borderRadius: BorderRadius.circular(12),
                       ),
                        

                        )   ,               validator: validator,
                        autovalidateMode: autovalidateMode,
                        inputFormatters:inputFormatters,
                        );
                  



  }
}

Showimageplace( BuildContext context, VoidCallback onGalleryTap, VoidCallback cameretap ){
 
  showModalBottomSheet(
    backgroundColor:  const Color.fromRGBO(22, 38, 52, 1),
    context: context, builder: (builder){
 
    return  Padding(
      padding: const EdgeInsets.only(top: 65),
      child: SizedBox( width: MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height/6
      ,child: 
      
       Row(
        children: [
          
           Expanded(
            child: InkWell(
              onTap: (){
                onGalleryTap();
              },
              child: const SizedBox( 
                child: Column(
                   children: [
                    Icon( Iconsax.gallery_import,color: Colors.white,size: 70,)
                    ,Text("Gallery",style: TextStyle(color: Colors.white),)
                   ],
                ),
                          
              ),
            ),
          )
            ,Expanded(
              child: InkWell(
               
              onTap: (){
                cameretap();
                 
              } ,child: const SizedBox( 
                child: Column(
                   children: [
                    Icon( Iconsax.camera,color: Colors.white,size: 70,)
                    ,Text("Camere",style: TextStyle(color: Colors.white),)
                   ],
                ),
              
              ),
                      ),
            )
        ],
       )
      
      ),
    );
  });
}




