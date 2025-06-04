import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../data/data.dart';
import '../models/sanpham.dart';
import '../screens/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nội dung chính ở đây
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/dongho.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //sử lý sự kiện
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/RolexVang.png'),
                              SizedBox(height: 20),
                              Text('Đồng Hồ Vàng'),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //sử lý sự kiện
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/rolexKC.png'),
                              SizedBox(height: 20),
                              Text('Đồng Hồ Kim Cương'),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                width: 168,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF662D91), width: 2),
                  ),
                ),
                child: Text('SẢN PHẨM BÁN CHẠY'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GenderStatusButtons(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    itemCount: sanpham.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                    itemBuilder: (context, index) {
                      return SanPhamWidget(sanPham: sanpham[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

void showSlideMenu(BuildContext context) {
  late OverlayEntry overlay;
  overlay = OverlayEntry(
    builder: (context) => MenuScreen(
      onClose: () {
        overlay.remove();
      },
    ),
  );

  Overlay.of(context).insert(overlay);
}

class GenderStatusButtons extends StatefulWidget {
  const GenderStatusButtons({super.key});
  @override
  GenderStatusButtonsState createState() => GenderStatusButtonsState();
}

class GenderStatusButtonsState extends State<GenderStatusButtons> {
  String selected = 'nam';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Nút Đồng Hồ Nam
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 'nam';
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: selected == 'nam' ? Color(0xFF662D91) : Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Đồng Hồ Nam',
                style: TextStyle(
                  color: selected == 'nam' ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Nút Đồng Hồ Nữ
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 'nu';
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selected == 'nu' ? Color(0xFF662D91) : Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Đồng Hồ Nữ',
                style: TextStyle(
                  color: selected == 'nu' ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SanPhamWidget extends StatefulWidget {
  final SanPham sanPham;

  const SanPhamWidget({super.key, required this.sanPham});

  @override
  State<SanPhamWidget> createState() => _SanPhamWidgetState();
}

class _SanPhamWidgetState extends State<SanPhamWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.sanPham.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: widget.sanPham.yeuThich
                            ? [
                                BoxShadow(
                                  color: Colors.purple.shade100,
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: IconifyIcon(
                          key: ValueKey(widget.sanPham.yeuThich),
                          icon: widget.sanPham.yeuThich
                              ? 'iconoir:heart-solid'
                              : 'iconoir:heart',
                          color: const Color(0xFF662D91),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.sanPham.tenSanPham,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Text(
            widget.sanPham.maSanPham,
            style: const TextStyle(
              color: Color(0xFF662D91),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.sanPham.moTa,
            style: const TextStyle(fontSize: 12, color: Color(0xFF662D91)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Giá ${_formatCurrency(widget.sanPham.donGia)}đ',
            style: const TextStyle(
              color: Color(0xFF662D91),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF662D91),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Thêm Vào Giỏ'),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}
