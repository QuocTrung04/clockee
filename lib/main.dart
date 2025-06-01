import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFF3F3F3),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF662D91), width: 2.0),
                ),
              ),
              child: AppBar(
                backgroundColor: Color(0xFFFFFFFF),
                centerTitle: true,
                toolbarHeight: 60,
                title: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: IconifyIcon(
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
                            icon: IconifyIcon(
                              icon: 'ic:round-search',
                              color: Color(0xFF662D91),
                            ),
                          ),
                          SizedBox(width: 5),
                          IconButton(
                            onPressed: () {},
                            icon: IconifyIcon(
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
            ),
          ),
          body: SingleChildScrollView(child: Column()), //giao dien chinh
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            backgroundColor: Color(0xFFF3F3F3),
            animationCurve: Curves.linear,
            animationDuration: const Duration(milliseconds: 300),
            items: [
              IconifyIcon(icon: 'iconoir:home', color: Color(0xFF662D91)),
              IconifyIcon(
                icon: 'icon-park-twotone:phone',
                color: Color(0xFF662D91),
              ),
              IconifyIcon(icon: 'iconoir:heart', color: Color(0xFF662D91)),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
