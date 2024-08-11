import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


PreferredSize userappbar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(150.0), // Adjusted to a fixed height
    child: Stack(
      children: <Widget>[
        // Background container with curved bottom
        Container(
          width: MediaQuery.of(context).size.width,
          height: 430.0, 
          decoration: const BoxDecoration(
            color: Color.fromRGBO(25, 61, 93, 0.525),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(66.0), // Adjust the radius as needed
              bottomRight: Radius.circular(66.0),
            ),
          ),
          child: const Center(
            child: Text(
              "ADD STAFF",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Optional: Add more elements like search bar, buttons, etc. in the stack if needed
      ],
    ),
  );
}


class usertextfield extends StatelessWidget {
   final  TextEditingController  controller;
    final String lebelname;
  const usertextfield({super.key
   ,required this.controller
   
   , required this.lebelname
   
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
                        enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                         borderSide: const BorderSide(
                         width: 2,
                        color: Color.fromARGB(255, 32, 58, 81),)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),



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

