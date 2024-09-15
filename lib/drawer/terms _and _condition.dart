import 'package:flutter/material.dart';
import 'package:staff/custum/textcostom.dart';

class Terms_And_Condition extends StatelessWidget {
  const Terms_And_Condition({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        title: const Apptext("Terms & condition"),
      ),
      
      body: const Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}