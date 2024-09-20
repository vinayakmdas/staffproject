import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/custum/navigator.dart';
import 'package:staff/custum/textcostom.dart';
import 'package:staff/drawer/about.dart';
import 'package:staff/drawer/contact.dart';
import 'package:staff/drawer/privacy_policy.dart';
import 'package:staff/drawer/terms%20_and%20_condition.dart';
import 'package:staff/login%20and%20%20sign%20up/login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
      Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    navigatpushremoveuntil(context, Loginpage());
  }
    return  Scaffold(
      appBar: AppBar(
        title: Apptext("Settings"),
        centerTitle: true,
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
                      onTap: () {navigatepush(context, Terms_And_Condition());}),
                  ListTile(
                      leading: const Icon(
                        Icons.connect_without_contact_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(' contact Us ',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {navigatepush(context, Contact());}),
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