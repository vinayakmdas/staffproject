import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:staff/custum.dart/AppBar.dart';
import 'package:staff/custum.dart/navigator.dart';

import 'package:staff/taskadd/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(87),
          child: CustomAppBar(
            title: const Text(
              " HOMESCREEN",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            trailing: IconButton(
                onPressed: () {navigatepush(context, TaskPage());},
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 43,
                  color: Colors.white,
                )),
          )),
      body: const SingleChildScrollView(
        

        
        child:   Column(

          children: [
         
            
            containerhomescreen(icons: Iconsax.tick_square, heading: 'Complete Work ',color:  Colors.green,),
            containerhomescreen(icons: Iconsax.close_square, heading: 'Pending work ',color:  Colors.red,),
             containerhomescreen(icons: Iconsax.people, heading: 'Complete Work ',color:  Colors.black,)
          ],
        ),
        
      ),

    );
  }
}
