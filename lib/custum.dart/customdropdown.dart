import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Widget customDropdownField({
  required String labelText,
  required String hintText,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  final FormFieldValidator<String>? validator,
}) {
  return DropdownButtonFormField<String>(
      style: TextStyle(color: Colors.white),
      dropdownColor: Color(0xFF1E1E1E),
      iconEnabledColor: Colors.white,
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator);
}


class cusstomContainer extends StatelessWidget {
 final    Widget data;
  const cusstomContainer ({super.key
  ,required this.data
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:53,
                      width: 353,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                        
                      ),
                      child: data,
         );
    
  }
}