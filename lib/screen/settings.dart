import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textcostom.dart';
import 'package:staff/custum/textfield.dart';
import 'package:staff/drawer/about.dart';
import 'package:staff/drawer/contact.dart';
import 'package:staff/drawer/privacy_policy.dart';
import 'package:staff/drawer/terms%20_and%20_condition.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';
import 'package:staff/model/signupmodel.dart';
import 'package:staff/service/signup_Data_Managing.dart';
import 'package:staff/service/staff_Data_managing.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
 final   _formkey = GlobalKey<FormState>();
  final ValueNotifier<String> currentPasswordNotifier = ValueNotifier("");
  final ValueNotifier<String> newPasswordNotifier = ValueNotifier("");
  final ValueNotifier<String> confirmPasswordNotifier = ValueNotifier("");

  final passwordcontroller = TextEditingController();
  final newpasswordcontroller = TextEditingController();
  final conformpassword = TextEditingController();
  String? currentpassword;
  
final datamanging=DataManaging();

changepassword() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? password = prefs.getString("userpassword");
  print("Current password retrieved: $password");
  setState(() {
    currentpassword = password;
  });
}

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changepassword();
    datamanging.openBox();
  }

  @override
  Widget build(BuildContext context) {
    @override

    Future<void> _logout(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
    navigatpushremoveuntil(context, Loginpage());
    }

  checkpassword() async {
  await datamanging.openBox();
  final newpassword = newpasswordcontroller.text.trim();
  final conformpasword = conformpassword.text.trim();

  print(currentpassword);  
  if (currentpassword == passwordcontroller.text) {
    if (newpassword == conformpasword) {
      print("Password is equal");

      int userIndex = 0;  
      SignUpModel user = datamanging.getUserAt(userIndex)!;
      user.password = newpassword;

      await datamanging.updatevalue(userIndex, user);
      print("New password in Hive: ${user.password}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userpassword", newpassword);

 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully!'))
      );

      _logout(context);  
      navigatepushreplacement(context, Loginpage());
    } else {

     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!'))

      );
        
      
    }
  } else {
   ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('current password do not match!'))
      );

   
  }
}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const  Color.fromRGBO(22, 38, 52, 1),
        foregroundColor: Colors.white,
        title: const Apptext("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: LottieBuilder.asset(
                    "asset/gif/animation/Animation - 1726819887165.json")),
            SizedBox(
              height: 34,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 42),
              child: Row(
                children: [
                  Apptext(
                    "Welcome back    !",
                    fontSize: 25,
                    fontweight: FontWeight.bold,
                    Colors: Color.  fromRGBO(22, 38, 52, 1),
                        
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 42),
              child: Row(
                children: [
                  Apptext(
                    "Your now password must  be different from \nprevios used password. ",
                    fontSize: 13,
                    fontweight: FontWeight.bold,
                    Colors: Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              
              child: Padding(
                padding: EdgeInsets.only(left: 27, right: 27),
                child: Column(
                  children: [
                    CostomTextField(
                        iconcolors: Colors.grey,
                        controller: passwordcontroller,
                        prefixicon: Icons.lock,
                        filedcolor: Colors.white,
                        lebelname: "current password",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        lebelcolor: Colors.grey,
                        bordercolor: Colors.grey,
                        textcontrollercolor: Colors.black),
                    SizedBox(
                      height: 10,
                    ),
                    CostomTextField(
                        iconcolors: Colors.grey,
                        controller: newpasswordcontroller,
                        prefixicon: Icons.lock,
                        filedcolor: Colors.white,
                        lebelname: "New password",
                        lebelcolor: Colors.grey,
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        bordercolor: Colors.grey,
                        textcontrollercolor: Colors.black,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                        ),
                    SizedBox(
                      height: 10,
                    ),
                    CostomTextField(
                        iconcolors: Colors.grey,
                        controller: conformpassword,
                        prefixicon: Icons.lock,
                        filedcolor: Colors.white,
                        lebelname: "Conform  password",
                        lebelcolor: Colors.grey,
                        bordercolor: Colors.grey,
                        
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        textcontrollercolor: Colors.black,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                        
                        ),
                       SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const   Color.fromRGBO(22, 38, 52, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if(_formkey.currentState!.validate() ){
                            checkpassword();
                          }
                          
                        },
                        child: const Apptext(
                          "Change password ",
                          Colors: Colors.white,
                          fontweight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
























































      endDrawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(90, 42, 50, 57).withOpacity(0.4),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(370))),
            child: Padding(
              padding: const EdgeInsets.only(top: 179),
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(
                        Icons.report,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'About Us ',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        navigatepush(context, const Aboutscreen());
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.security_outlined,
                        color: Colors.white,
                      ),
                      title: const Text('Privacy and policy',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        navigatepush(context, const Privacy_policy());
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.note_sharp,
                        color: Colors.white,
                      ),
                      title: const Text('Terms and condition ',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        navigatepush(context, Terms_And_Condition());
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.connect_without_contact_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(' contact Us ',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        navigatepush(context, Contact());
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text(' Log Out ',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromRGBO(22, 38, 52, 1),
                                title: const Text(
                                  'Log out',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Are you sure want to delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                  ElevatedButton(
                                      onPressed: () {
                                        _logout(context);
                                      },
                                      child: const Text('OK'))
                                ],
                              );
                            });
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
