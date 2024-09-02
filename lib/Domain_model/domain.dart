import 'package:flutter/material.dart';

Widget customDropdownField({
  required String labelText,
  required String hintText,
  required String? value,
  required List<DropdownMenuItem<String>> items, // Updated to accept DropdownMenuItem<String>
  required ValueChanged<String?> onChanged,
  FormFieldValidator<String>? validator,
}) {
  return DropdownButtonFormField<String>(
    style: const TextStyle(color: Colors.white),
    dropdownColor:  const Color.fromARGB(210, 4, 46, 82),
    iconEnabledColor: Colors.white,
    value: value,
    items: items, 
    
    onChanged: onChanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    
   
  );
}
