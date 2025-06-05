//import '../screens/account_screen.dart';
import 'dart:isolate';

import 'package:clockee/models/sanpham.dart';
import 'package:clockee/screens/account_information_screen.dart';
import 'package:clockee/screens/favorite_screen.dart';
import 'package:clockee/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../screens/account_screen.dart';
import 'custom_app_bar.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:clockee/data/data.dart';

class CustomMainScreen extends StatefulWidget {
  const CustomMainScreen({super.key});

  @override
  State<CustomMainScreen> createState() => _CustomMainScreenState();
}

bool isLoggedIn = true;

class _CustomMainScreenState extends State<CustomMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screen = [
    const HomeScreen(),
    const FavoriteScreen(),
    //const AccountScreen(),
    isLoggedIn ? const AccountInformationScreen() : const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: CustomAppBar(),
      body: IndexedStack(index: _currentIndex, children: _screen),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: const Color(0xFFF3F3F3),
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          IconifyIcon(icon: 'iconoir:home', color: Color(0xFF662D91)),
          IconifyIcon(icon: 'iconoir:heart', color: Color(0xFF662D91)),
          IconifyIcon(icon: 'line-md:account', color: Color(0xFF662D91)),
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
