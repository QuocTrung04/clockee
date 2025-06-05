import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class MenuScreen extends StatefulWidget {
  final VoidCallback onClose;

  const MenuScreen({super.key, required this.onClose});

  @override
  State<MenuScreen> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  void closeMenu() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black87,
        child: Stack(
          children: [
            GestureDetector(
              onTap: closeMenu,
              child: Container(color: Colors.transparent),
            ),

            SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.654,
                            color: Color(0xFF662D91),
                            child: Text(
                              'MENU',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: closeMenu,
                            icon: IconifyIcon(
                              icon: 'carbon:close-large',
                              color: Color(0xFF662D91),
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _menuItem('THƯƠNG HIỆU', () {
                      print("đây là thương hiệu");
                    }),
                    _menuItem('ĐỒNG HỒ ĐEO TAY', () {
                      print("Đây là đồng hồ đeo tay");
                    }),
                    _menuItem('ĐỒNG HỒ TRANG TRÍ', () {
                      print("đây là đồng hồ trang trí");
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFB3B3B3), width: 1.2),
        ),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
