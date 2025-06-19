import 'package:clockee/screens/account_information_screen.dart';
import 'package:clockee/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/account_screen.dart';
import 'custom_app_bar.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomMainScreen extends StatefulWidget {
  const CustomMainScreen({super.key});

  @override
  State<CustomMainScreen> createState() => _CustomMainScreenState();
}

class _CustomMainScreenState extends State<CustomMainScreen> {
  int _currentIndex = 1;

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadLoginStatus();
  }

  Future<void> _loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      //const FavoriteScreen(),
      Center(child: Text('data')),
      const HomeScreen(),
      _isLoggedIn ? const AccountInformationScreen() : const AccountScreen(),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: CustomAppBar(),
      body: IndexedStack(index: _currentIndex, children: screen),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: const Color(0xFFF3F3F3),
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          IconifyIcon(icon: 'iconoir:heart', color: Color(0xFF662D91)),
          IconifyIcon(icon: 'iconoir:home', color: Color(0xFF662D91)),
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
