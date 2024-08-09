import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:staff/screen.dart/homescreen.dart';
import 'package:staff/screen.dart/settings.dart';
import 'package:staff/screen.dart/staffscreen.dart';
import 'package:staff/screen.dart/work.dart';

class ButtonNavigationbar extends StatefulWidget {

  final int currentPage;
   const ButtonNavigationbar({super.key,this.currentPage=0});

  @override
  State<ButtonNavigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<ButtonNavigationbar> {
   final List<Widget> _screens = [
    const HomeScreen(),
       StaffScreen(),
    const WorkScreen(),
    const  Settings(),
  ];



 int _currentIndex = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentIndex=widget.currentPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Work',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.setting),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}