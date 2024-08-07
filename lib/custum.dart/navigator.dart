
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';

void navigatepush(BuildContext context, Widget page) {


  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void navigatepushreplacement(BuildContext context, Widget page) {


  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}


void navigatpushremoveuntil(BuildContext context, Widget page) {
Navigator.pushAndRemoveUntil(context, MaterialPageRoute
(builder: (context)=>page), (route) => false);

  

}

void navigatepop(BuildContext context, Widget page) {


  Navigator.pop(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
// =======================================================================


class LogoutAlert extends StatefulWidget {

  const LogoutAlert({super.key});

  @override
  State<LogoutAlert> createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
       cancel(){
      TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
    );
       }

         _logout(){
      TextButton(
      onPressed: () {
       navigatpushremoveuntil(context, Loginpage());
      },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
    );
       }

  @override
  Widget build(BuildContext context) {
    return   AlertDialog(
      backgroundColor:  Colors.red,
      title:const Text("Are you sure you want to logout?",
        style: TextStyle(color: Colors.white), ) ,
       
      actions: [
      cancel(),
      _logout(),
      
      ],

    );
  }
}
