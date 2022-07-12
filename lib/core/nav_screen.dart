import 'package:flutter/material.dart';

import '../configs/constants.dart';
//screens
import 'game/home_screen.dart';
import 'dashboard/dashboard.dart';
import 'settings/settings.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 1;

  static const List<Widget> _navScreens = [
    Dashboard(),
    HomeScreen(),
    Settings(),
  ];

  static const List<BottomNavigationBarItem> _navBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
        ),
        label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.notes_rounded), label: 'Quiz'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings_outlined,
        ),
        label: 'Settings'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navScreens.elementAt(_selectedIndex),
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: _navScreens,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        currentIndex: _selectedIndex,
        unselectedItemColor: kSecondaryTextColor,
        selectedFontSize: 18,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
