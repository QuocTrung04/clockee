import 'package:clockee/screens/login_screen.dart';
import 'package:clockee/screens/profile_screen.dart';
import 'package:clockee/screens/support_screen.dart';
import 'package:clockee/widgets/custom_main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'address_screen.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        children: [
          // Phần đầu: Stack chứa ảnh, avatar, tên
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Ảnh nền
              Image.asset(
                'assets/images/watch.png',
                width: width,
                fit: BoxFit.cover,
              ),

              Positioned(
                bottom: 10,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: IconifyIcon(
                    icon: 'emojione:pouting-cat-face',
                    size: 60,
                  ),
                ),
              ),

              // Tên người dùng bên cạnh avatar
              Positioned(
                bottom: 20,
                left: 120,
                child: const Text(
                  'Quốc Trung',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Phần dưới: nội dung thông tin tài khoản
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.purpleAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    Icons.shopping_bag,
                    'Thông tin tài khoản',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.shopping_bag, 'Đơn hàng', onTap: () {}),
                  _buildMenuItem(
                    Icons.location_on,
                    'Địa chỉ',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.help_outline,
                    'Hỗ trợ',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupportScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.logout,
                    'Đăng xuất',
                    isLogout: true,
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove(
                        'isLoggedIn',
                      ); // hoặc: await prefs.setBool('isLoggedIn', false);

                      // Quay lại màn hình đăng nhập và xoá các màn hình khác khỏi ngăn xếp
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomMainScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    bool isLogout = false,
    VoidCallback? onTap, // <-- thêm callback
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, // <- gán hành động khi bấm
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: isLogout ? Colors.red : Colors.black87),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isLogout ? Colors.red : Colors.black87,
                  fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
