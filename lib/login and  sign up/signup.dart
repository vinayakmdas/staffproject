import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textcostom.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';
import 'package:staff/model.dart/signupmodel.dart';

import 'package:staff/service.dart/signup_Data_Managing.dart';


class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  DataManaging _dataManaging = DataManaging();

  bool _confirmobscure = true;
  bool _passwordobscure = true;

  final _signupusername = TextEditingController();

  final _emailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  final _confirmpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool passwordsecured = true;
  bool passwordunsecured = true;

  Future registration() async {
    final username = _signupusername.text.trim();
    final email = _emailcontroller.text;
    final password = _passwordcontroller.text;
    final confirm = _confirmpassword.text;

    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirm.isNotEmpty) { 
      SignUpModel signUpModel = SignUpModel(
          username: username,
          email: email,
          password: password,
          conformpassword: confirm);
      _dataManaging.adduser(signUpModel);
      print("signup data saved");
      navigatepushreplacement(context, const Loginpage());
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
                        "SIGN UP",
                        Colors: Colors.white,
                        fontSize: 24,
                        fontweight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CostomTextField(
                      controller: _signupusername,
                      prefixicon: Iconsax.user,
                      filedcolor: const Color.fromARGB(37, 158, 158, 158),
                      lebelname: 'Username  :',
                      lebelcolor: Colors.white,
                      bordercolor: Colors.white,
                      textcontrollercolor: Colors.white,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.deny(RegExp(r'\s'))
                      // ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " Please enter the username";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CostomTextField(
                    controller: _emailcontroller,
                    prefixicon: Icons.mail,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'E-mail  :',
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CostomTextField(
                    controller: _passwordcontroller,
                    prefixicon: Icons.lock,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'Password :',
                    lebelcolor: Colors.white,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    bordercolor: Colors.white,
                    obscureText: _passwordobscure,
                    textcontrollercolor: Colors.white,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    suffixicon: IconButton(
                      icon: Icon(
                        _passwordobscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordobscure = !_passwordobscure;
                        });
                      },
                    ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  CostomTextField(
                    controller: _confirmpassword,
                    prefixicon: Icons.lock_reset,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'Confirm password :',
                    suffixicon: IconButton(
                      icon: Icon(
                        _confirmobscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmobscure = !_confirmobscure;
                        });
                      },
                    ),
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white,
                    obscureText: _confirmobscure,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _passwordcontroller.text) {
                        return 'Passwords do not match';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            registration();
                          }
                        },
                        child: const Apptext(
                          "SIGN UP",
                          Colors: Color.fromRGBO(47, 22, 52, 1),
                          fontweight: FontWeight.bold,
                        )),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 55,
                      ),
                      const Apptext(
                        "Already you have an account?",
                        Colors: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {
                            navigatepushreplacement(context, const Loginpage());
                          },
                          child: const Apptext('Log in'))
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
