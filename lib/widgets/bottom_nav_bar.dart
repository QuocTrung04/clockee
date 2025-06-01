import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:iconify_design/iconify_design.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: const Color(0xFFF3F3F3),
      animationCurve: Curves.linear,
      animationDuration: const Duration(milliseconds: 200),
      items: const [
        IconifyIcon(icon: 'iconoir:home'),
        IconifyIcon(icon: 'iconamoon:phone-thin'),
        IconifyIcon(icon: 'iconoir:heart'),
      ],
    );
  }
}
