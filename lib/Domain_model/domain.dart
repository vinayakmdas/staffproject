import 'package:flutter/material.dart';

Widget customDropdownField({
  required String labelText,
  required String hintText,
  required String? value,
  required List<DropdownMenuItem<String>> items,
  required ValueChanged<String?> onChanged,
  FormFieldValidator<String>? validator,
}) {
  



  bool isValidValue = items.any((DropdownMenuItem<String> item) => item.value == value);

 
  print('Is valid value: $isValidValue');

  return DropdownButtonFormField<String>(
    
    style: const TextStyle(color: Colors.white),
    dropdownColor: const Color.fromARGB(210, 4, 46, 82),
    iconEnabledColor: Colors.white,
    value: isValidValue ? value : null,  
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
