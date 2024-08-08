import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:staff/custum.dart/navigator.dart';
import 'package:staff/custum.dart/textcostom.dart';
import 'package:staff/custum.dart/textfield.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';
import 'package:staff/model.dart/signupmodel.dart';
import 'package:staff/service.dart/signup_Data_Managing.dart';

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();

}

class _signupState extends State<signup> {
  DataManaging _dataManaging = DataManaging();

  final _signupusername = TextEditingController();

  final _emailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  final _confirmpassword = TextEditingController();
   final _formkey = GlobalKey<FormState>();

bool passwordsecured =true;
bool passwordunsecured=true;

 Future registration()async{

    final username=_signupusername.text;
    final email= _emailcontroller.text;
    final password= _passwordcontroller.text;
    final confirm=_confirmpassword.text;

    if(username.isNotEmpty &&email.isNotEmpty && password.isNotEmpty&& confirm.isNotEmpty){

       SignUpModel signUpModel = SignUpModel(
      username: username,
       email: email, 
       password: password, 
       conformpassword: confirm

       
       
       );
         _dataManaging.adduser(signUpModel);
       print("signup data saved");
        navigatepushreplacement(context, Loginpage());
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
      backgroundColor: Color.fromRGBO(22, 38, 52, 1),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 250, left: 50, right: 50),
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
                    filedcolor: Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'username  :',
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white
                    ,validater: (value){
                      if(value==null|| value.isEmpty){
                        return " please enter the username";
                      }
                      else{
                        return null;
                      }                   
                    }
                    
                    
                    ),
                SizedBox(
                  height: 20,
                ),
                CostomTextField(
                    controller: _emailcontroller,
                    prefixicon: Icons.mail,
                    filedcolor: Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'E mail  :',
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white),
                SizedBox(
                  height: 20,
                ),
                CostomTextField(
                    controller: _passwordcontroller,
                    prefixicon: Icons.lock,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'password :',
                    suffixicon: Iconsax.eye,
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white),
                const SizedBox(
                  height: 20,
                ),
                CostomTextField(
                    controller: _confirmpassword,
                    prefixicon: Icons.lock_reset,
                    filedcolor: const Color.fromARGB(37, 158, 158, 158),
                    lebelname: 'confirm password :',
                    suffixicon: Iconsax.eye,
                    lebelcolor: Colors.white,
                    bordercolor: Colors.white,
                    textcontrollercolor: Colors.white,
                    validater: (value) {
                     if (value == null || value.isEmpty) {
                   return 'Please confirm your password';
                    } else if (value != _passwordcontroller.text) {
                    return 'Passwords do not match';
                              }
                              return null;
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
                       registration();
                      },
                      child: const Apptext(
                        "SIGN UP",
                        Colors: Color.fromRGBO(47, 22, 52, 1),
                        fontweight: FontWeight.bold,
                      )),
                ),
                Row(
                  children: [
                    const Apptext(
                      "Aready you have an account?",
                      Colors: Colors.white,
                    ),
                    TextButton(onPressed: () { navigatepushreplacement(context, Loginpage());
                    }, child: const Apptext('Log in'))
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
