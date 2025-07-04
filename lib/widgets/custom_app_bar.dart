import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';
import '../data/data.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  User? user;

  // int tinhSoLuong() {
  //   final cart = Provider.of<AppData>(context).cartItems;
  //   int soluong = 0;
  //   for (var itemsl in cart) {
  //     soluong += itemsl.quantity;
  //   }
  //   return soluong;
  // }
  int tinhSoLuong() {
    int quantity = 0;
    final cartItems = Provider.of<AppData>(context).cartItems;
    for (var itemsl in cartItems) {
      quantity += itemsl.quantity;
    }
    return quantity;
  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<AppData>(context, listen: false).user;

    if (user != null) {
      _loadCart();
    }
  }

  void _loadCart() async {
    final appData = Provider.of<AppData>(context, listen: false);

    if (user != null) {
      try {
        final items = await ApiService.fetchCartItem(user!.userId!);
        appData.setCart(items);
      } catch (e) {}
    }
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
                      showSlideSearch(context);
                    },
                    icon: const IconifyIcon(
                      icon: 'ic:round-search',
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
