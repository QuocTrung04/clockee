import 'dart:ui';

import 'package:clockee/data/data.dart';
import 'package:clockee/models/user.dart';
import 'package:clockee/screens/login_screen.dart';
import 'package:clockee/screens/order_screen.dart';
import 'package:clockee/screens/profile_screen.dart';
import 'package:clockee/screens/support_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:clockee/widgets/custom_main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'address_screen.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  int? userId;
  String? _displayName;
  @override
  void initState() {
    super.initState();
    _loadUserid();
  }

  Future<void> _loadUserid() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('userid');
    if (!mounted) return;

    if (id == null) {
      debugPrint('User ID not found');
      return;
    }

    try {
      final user = await ApiService.fetchUser(id); // <-- chờ API
      if (!mounted) return;
      setState(() {
        userId = id;
        _displayName = user.name;
      });
      debugPrint(
        "Fetched displayName: $_displayName",
      );
    } catch (e) {
      debugPrint('Error fetching user: $e');
    }
  }

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
                  child: IconifyIcon(icon: 'mdi:account', size: 60),
                ),
              ),

              // Tên người dùng bên cạnh avatar
              Positioned(
                bottom: 20,
                left: 120,
                child: Text(
                  _displayName ?? "Đang tải..",
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
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                      if (result == true) {
                        _loadUserid(); // GỌI LẠI API để lấy user mới
                      }
                    },
                  ),
                  _buildMenuItem(
                    Icons.shopping_bag,
                    'Đơn hàng',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen()),
                      );
                    },
                  ),
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
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Xác nhận đăng xuất'),
                          content: Text(
                            'Bạn có chắc chắn muốn đăng xuất không?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false), // Huỷ
                              child: Text('Huỷ'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, true), // Đồng ý
                              child: Text(
                                'Đăng xuất',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomMainScreen(),
                          ),
                          (route) => false,
                        );
                      }
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
    VoidCallback? onTap,
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
