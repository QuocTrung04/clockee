import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:iconify_design/iconify_design.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      backgroundColor: const Color(0xFFF3F3F3),
      animationCurve: Curves.linear,
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        IconifyIcon(icon: 'iconoir:home', color: Color(0xFF662D91)),
        IconifyIcon(icon: 'iconoir:phone', color: Color(0xFF662D91)),
        IconifyIcon(icon: 'iconoir:heart', color: Color(0xFF662D91)),
      ],
    );
  }
}
