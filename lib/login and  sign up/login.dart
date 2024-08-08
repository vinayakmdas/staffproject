import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textcostom.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/login%20and%20%20sign%20up/signup.dart';
import 'package:staff/model.dart/signupmodel.dart';

import 'package:staff/service.dart/signup_Data_Managing.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final DataManaging _dataManaging = DataManaging();
  bool _passwordobscure=true;
  final _formkey = GlobalKey<FormState>();
   void checkLogin() {
    final logusername = _usernamecontroller.text.trim();
    final logpassword = _passwordcontroller.text.trim();
    final List<SignUpModel> users = _dataManaging.getUsers();

    bool userFound = false;
    for (SignUpModel user in users) {
      if (user.username == logusername && user.password == logpassword) {
        userFound = true;
        break;
      }
    }

    if (userFound) {
      Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }
      navigatepushreplacement(context, ButtonNavigationbar());

      saveLoginState();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  void initState() {
    _dataManaging.openBox();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 38, 52, 1),
      body: SingleChildScrollView(
     
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 300, left: 19, right: 50),
            child: Column(
              children: [
                const Row(
                  children: [
                    Apptext(
                      "LOG IN",
                      fontSize: 24,
                      fontweight: FontWeight.bold,
                      Colors: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CostomTextField(
                    controller: _usernamecontroller,
                    prefixicon: Iconsax.user,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: ("username"),
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white,

                     inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-z,A-Z]')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " please enter the username";
                      } else {
                        return null;
                      }
                    }
                ),
                const SizedBox(
                  height: 20,
                ),
                CostomTextField(
                  controller: _passwordcontroller,
                  obscureText: _passwordobscure,
                  prefixicon: Iconsax.lock,
                  filedcolor: const Color.fromARGB(37, 158, 158, 158),
                  lebelname: ("password  :"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  lebelcolor: Colors.white,
                  bordercolor: Colors.white,
                  textcontrollercolor: Colors.white,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return " enter your password";
                    }
                    else{
                      return null;
                    }
                  },
               suffixicon:   IconButton(
                      icon: Icon(
                        _passwordobscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordobscure = !_passwordobscure;
                        });
                      },
                    ),
            
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
 checkLogin();

                        }
                       
                      },
                      child: const Apptext(
                        "LOG IN",
                        Colors: Color.fromRGBO(47, 22, 52, 1),
                        fontweight: FontWeight.bold,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Apptext(
                      "Don't have an account?",
                      Colors: Colors.white,
                    ),
                    TextButton(
                        onPressed: () {
                          navigatepushreplacement(context, signup());
                        },
                        child: const Apptext('sign up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
