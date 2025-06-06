import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:badges/badges.dart' as badges;
import '../screens/home_screen.dart';
import '../data/data.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int tinhSoLuong() {
    int soluong = 0;
    for (var itemsl in cartItems) {
      soluong += itemsl.soLuong;
    }
    return soluong;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF662D91), width: 2.0),
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF3F3F3),
        centerTitle: true,
        toolbarHeight: 60,
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showSlideMenu(context);
                    },
                    icon: const IconifyIcon(
                      icon: 'ri:menu-2-line',
                      color: Color(0xFF662D91),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset('assets/images/Logo.png', height: 50)],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showSlideSearch(context);
                    },
                    icon: const IconifyIcon(
                      icon: 'ic:round-search',
                      color: Color(0xFF662D91),
                    ),
                  ),
                  const SizedBox(width: 5),
                  badges.Badge(
                    badgeContent: Text(
                      '${tinhSoLuong()}',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showSlideCart(context);
                      },
                      icon: const IconifyIcon(
                        icon: 'solar:cart-bold',
                        color: Color(0xFF662D91),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
