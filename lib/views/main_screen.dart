import 'package:flutter/material.dart';
import 'package:planety_app/views/cart_screen.dart';
import 'package:planety_app/views/home_screen.dart';
import 'package:planety_app/views/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> children = [
    HomeScreen(),
    CartScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: ''),
        ],
      ),
    );
  }
}
