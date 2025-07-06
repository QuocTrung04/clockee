import 'package:clockee/data/data.dart';
import 'package:clockee/screens/account_information_screen.dart';
import 'package:clockee/screens/favorite_screen.dart';
import 'package:clockee/screens/home_screen.dart';
import 'package:clockee/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final bool _isLoggedIn = appData.user != null;
    final List<Widget> screen = [
      _isLoggedIn
          ? const FavoriteScreen()
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn Chưa Đăng Nhập',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF662D91),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 230,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [Colors.purple, Colors.pink],
                          ),
                        ),
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      // Center(child: Text('data')),
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
