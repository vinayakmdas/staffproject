import 'package:flutter/material.dart';


class CostomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String lebelname;
  final Color filedcolor;
  final Color textcontrollercolor;
  final Color lebelcolor;
  final IconData prefixicon;
  final Color bordercolor;
  final IconData?suffixicon;
 final String? Function(String?)? validator;
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
      required this.textcontrollercolor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: textcontrollercolor),
      decoration: InputDecoration(
        suffixIcon: Icon(suffixicon),
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
      validator: validator,
      // inputFormatters: [],
    );
  }
}




