import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/bottomnavoagator/buttomnavigator.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textcostom.dart';
import 'package:staff/custum/textfield.dart';
import 'package:staff/login%20and%20%20sign%20up/signup.dart';
import 'package:staff/model/signupmodel.dart';


import 'package:staff/service/signup_Data_Managing.dart';


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

  // Log the entered username and password
  print('Entered Username: $logusername');
  print('Entered Password: $logpassword');

  bool userFound = false;
  for (SignUpModel user in users) {
    // Log the stored username and password for comparison
    print('Stored Username: ${user.username}');
    print('Stored Password: ${user.password}');

    if (user.username == logusername && user.password == logpassword) {
      userFound = true;
      break;
    }
  }

  if (userFound) {
    Future<void> saveLoginState() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userpassword', logpassword);
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
      body: Center(
        child: SingleChildScrollView(
             
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                      lebelname: ("Username :"),
                      lebelcolor: Colors.white,
                      bordercolor: Colors.white,
                      textcontrollercolor: Colors.white,
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                         iconcolors: Colors.white,
              
                      //  inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp('[a-z,A-Z]')),
                      // ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " Please enter the username";
                        } else {
                          return null;
                        }
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CostomTextField(
                    iconcolors: Colors.white,
                    controller: _passwordcontroller,
                    obscureText: _passwordobscure,
                    prefixicon: Iconsax.lock,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: ("Password :"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return " Enter your password";
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
                      SizedBox(width: 70,),
                      const Apptext(
                        "Don't have an account?",
                        Colors: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {
                            navigatepushreplacement(context, Signup());
                          },
                          child: const Apptext('Sign up'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
