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
  CostomTextField(
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
      controller: controller,
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




