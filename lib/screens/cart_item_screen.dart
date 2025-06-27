import 'package:clockee/data/data.dart';
import 'package:clockee/screens/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:clockee/models/cart.dart';

class CartItemScreen extends StatefulWidget {
  final VoidCallback onClose;

  const CartItemScreen({super.key, required this.onClose});
  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controler;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controler = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.easeInOut));
    _controler.forward();
  }

  void _closeSlideCart() async {
    await _controler.reverse();
    widget.onClose();
  }

  @override
  void dispose() {
    _controler.dispose();
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
              onTap: _closeSlideCart,
              child: Container(color: Colors.transparent),
            ),
            SlideTransition(
              position: _slideAnimation,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Giỏ Hàng,',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${tinhSoLuong()} sản phẩm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: _closeSlideCart,
                              icon: IconifyIcon(
                                icon: 'material-symbols-light:close-rounded',
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return CartItemWidget(
                              item: item,
                              onIncrease: () {
                                setState(() {
                                  item.soLuong++;
                                });
                              },
                              onDecrease: () {
                                setState(() {
                                  if (item.soLuong > 1) item.soLuong--;
                                });
                              },
                              onDelete: () {
                                setState(() {
                                  cartItems.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: SafeArea(
                          child: cartItems.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      'Không có sản phẩm trong giỏ hàng',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tổng tiền hàng',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${_formatCurrency(tinhTongTien())}đ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await _controler.reverse();
                                          widget.onClose();
                                          if (!mounted) return;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PayScreen(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purple,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Mua ngay',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int tinhSoLuong() {
    int soluong = 0;
    for (var itemsl in cartItems) {
      soluong += itemsl.soLuong;
    }
    return soluong;
  }

  int tinhTongTien() {
    int tongtien = 0;
    for (var itemtt in cartItems) {
      tongtien += itemtt.soLuong * itemtt.price;
    }
    return tongtien;
  }
}

class CartScreen extends StatefulWidget {
  final List<CartItem> items;

  const CartScreen({super.key, required this.items});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _increaseQuantity(int index) {
    setState(() {
      widget.items[index].soLuong++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (widget.items[index].soLuong > 1) {
        widget.items[index].soLuong--;
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  void tinhTongTien(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return CartItemWidget(
            item: item,
            onIncrease: () => _increaseQuantity(index),
            onDecrease: () => _decreaseQuantity(index),
            onDelete: () => _deleteItem(index),
          );
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.network(
            item.imageUrl,
            width: 90,
            height: 120,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.tenSanPham),
                SizedBox(height: 7),
                Text(
                  item.maSanPham,
                  style: TextStyle(color: Color(0xFF662D91)),
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      'Giá:\t ${_formatCurrency(item.price)}đ',
                      style: TextStyle(
                        color: Color(0xFF662D91),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    IconButton(
                      onPressed: onDecrease,
                      icon: IconifyIcon(icon: 'gala:remove'),
                    ),
                    Text(' ${item.soLuong}'),
                    IconButton(
                      onPressed: onIncrease,
                      icon: IconifyIcon(icon: 'gala:add'),
                    ),

                    Spacer(),
                    IconButton(
                      onPressed: onDelete,
                      icon: IconifyIcon(
                        icon: 'mdi-light:delete',
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatCurrency(int price) {
  return price.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );
}
