import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';  // Import the google_nav_bar package
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:staff/screen.dart/homescreen.dart';
import 'package:staff/screen.dart/settings.dart';
import 'package:staff/screen.dart/staffscreen.dart';
import 'package:staff/screen.dart/work.dart';

class ButtonNavigationbar extends StatefulWidget {
  final int currentPage;
  const ButtonNavigationbar({super.key, this.currentPage = 0});

  @override
  State<ButtonNavigationbar> createState() => _ButtonNavigationbarState();
}

class _ButtonNavigationbarState extends State<ButtonNavigationbar> {
  final List<Widget> _screens = [
    const HomeScreen(),
    StaffScreen(),
    const WorkScreen(),
    const Settings(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: GNav(
        
        hoverColor: const Color.fromARGB(255, 255, 255, 255),
        gap: 8,
        activeColor: const Color.fromRGBO(22, 38, 52, 1),
        iconSize: 32,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        duration: Duration(milliseconds: 300),
        color: Colors.grey[800],
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        tabs: const [
          GButton(
            icon: Iconsax.home,
            text: 'Home',
          ),
          GButton(
            icon: Iconsax.user,
            text: 'Staff',
          ),
          GButton(
            icon: Iconsax.home,
            text: 'Work',
          ),
          GButton(
            icon: Iconsax.setting,
            text: 'Settings',
          ),
        ],
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
