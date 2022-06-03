import 'package:flutter/material.dart';
import 'package:kadojopapp/screens/contact.dart';
import 'package:kadojopapp/screens/home.dart';
import 'package:kadojopapp/screens/projectscreen.dart';

import '../Model/shar.dart';
import 'setting/setting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> page = [home(), ProlectScreen(), Contact(), Setting()];
  List<String> title = [
    'Todo App',
    'Done App',
    'Archived App',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int) {
          setState(() {
            _selectedIndex = int;
            print(int);
          }); },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF285681)),
            label: 'Home',),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Color(0xFF285681)),
            label: 'Project',),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_rounded, color: Color(0xFF285681)),
            label: 'Contact',
            activeIcon: Icon(Icons.send_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color(0xFF285681)),
            label: 'Settings',),
        ],
        selectedItemColor: TextColors,
      ),
      body: page[_selectedIndex],
    );
  }
}
