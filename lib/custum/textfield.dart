import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CostomTextField extends StatelessWidget {
  final TextEditingController controller;
  final AutovalidateMode ?autovalidateMode;
 final bool obscureText ;
  final String lebelname;
  final Color filedcolor;
  final Color textcontrollercolor;
  final Color lebelcolor;
  final IconData prefixicon;
  final Color bordercolor;
  final Widget ?suffixicon;
 final String? Function(String?)? validator;
   final List<TextInputFormatter>? inputFormatters;
 const CostomTextField(
      {super.key,
      this.suffixicon,

      required this.controller,
      required this.prefixicon,
      required this.filedcolor,
      required this.lebelname,
      required this.lebelcolor,
      required this.bordercolor,
          this. validator,
          this.autovalidateMode,
          this.inputFormatters,
          this.obscureText = false,
      required this.textcontrollercolor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller ,
    
      style: TextStyle(color: textcontrollercolor),
      decoration: InputDecoration(
        suffixIcon:suffixicon,
        prefixIcon: Icon(
          prefixicon,
          color: Colors.white,
          
        ),
        
        fillColor: filedcolor,
        filled: true,
      
        label: Text(
          lebelname,
          style: TextStyle(color: lebelcolor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(12),
          
        ),
      ),
           obscureText: obscureText,
autovalidateMode: autovalidateMode,
      inputFormatters:  inputFormatters,
      validator: validator,
      // inputFormatters: [],
    );
  }
}




class CostomSerchBar extends StatelessWidget {
final   TextEditingController? controller;
    final Widget ?suffixicon; 
 
  const CostomSerchBar({super.key 
  ,this.controller
, this.suffixicon
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 23),
        child: TextFormField(
          
           controller: controller,
           decoration: InputDecoration(
                    hintText: 'Search....',
                  
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: suffixicon,
                    border: OutlineInputBorder( 
                      
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide( color: const Color.fromARGB(255, 28, 21, 21)) ,
                      
                    ),
                      filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                  )
        ),
      ),
    );
  }
}

class calender extends StatelessWidget {
   final TextEditingController controller;

  final String lebelname;
  final Color filedcolor;

  final Color lebelcolor;
 FormFieldValidator<String>? validator;
  final Color bordercolor;
  final Widget ?suffixicon;
   calender({super.key
  , required this.bordercolor 
  ,required this.lebelcolor,
  required this.filedcolor,
  required this.suffixicon,
  required this.lebelname,
  required this.controller
   ,this.validator
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      style:  const TextStyle( color: Colors.white),
      readOnly: true,
           validator: validator,
       decoration: InputDecoration(
        suffixIcon:suffixicon,
       
        
        fillColor: filedcolor,
        filled: true,

        label: Text(
          lebelname,
          style: TextStyle(color: lebelcolor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(12),
          ),
         ),
        
      
    );
  }
}


class Descritton extends StatelessWidget {
 final TextEditingController controller;

  final Color bordercolor;

  const Descritton({super.key,
   required this.controller
 , required this.bordercolor
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(

       controller: controller,
      style:  const TextStyle( color: Colors.white),
    

       decoration: InputDecoration(
    
        
      
        fillColor: const Color.fromRGBO(22, 38, 52, 1),
        filled: true,

        border: OutlineInputBorder(
          // borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(12),
          ),
         ),
     
    );
  }
}