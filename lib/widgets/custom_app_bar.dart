import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF662D91), width: 2.0),
        ),
      ),
      child: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        toolbarHeight: 60,
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
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
                children: [
                  Image.asset('assets/images/Logo.png', height: 50),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const IconifyIcon(
                      icon: 'ic:round-search',
                      color: Color(0xFF662D91),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: const IconifyIcon(
                      icon: 'solar:cart-bold',
                      color: Color(0xFF662D91),
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
