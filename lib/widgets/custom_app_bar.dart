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

  int tinhSoLuong() {
    final cartItems = Provider.of<AppData>(context).cartItems;
    int soLuong = cartItems.fold(0, (sum,item) => sum + item.quantity);
    // for (var itemsl in cartItems) {
    //   quantity += itemsl.quantity;
    // }\
    // return quantity;
    return soLuong;
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
                  Builder(builder: (context) {
                    final appData = Provider.of<AppData>(context);
                    int soLuong = appData.cartItems.fold(0, (sum, item) => sum + item.quantity);

                    return Stack(
                      children: [
                        IconButton(
                          onPressed: () => showSlideCart(context),
                          icon: const IconifyIcon(
                            icon: 'solar:cart-bold',
                            color: Color(0xFF662D91),
                          ),
                        ),
                        if (soLuong > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 18,  // chiều rộng cố định
                              height: 18, // chiều cao cố định
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: FittedBox(  // để chữ co vừa trong vòng tròn
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '$soLuong',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
