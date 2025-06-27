import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = ['Chờ xác nhận', 'Đang vận chuyển', 'Đã Mua'];

  final Map<String, List<Map<String, dynamic>>> _demoOrders = {
    'Chờ xác nhận': [
      {
        'name': 'Giày Thể Thao',
        'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
        'price': 200000,
        'quantity': 1,
      },
      {
        'name': 'Giày Thể Thao',
        'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
        'price': 200000,
        'quantity': 1,
      },
      {
        'name': 'Giày Thể Thao',
        'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
        'price': 200000,
        'quantity': 1,
      },
    ],
    'Đang vận chuyển': [
      {
        'name': 'Áo Hoodie',
        'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
        'price': 150000,
        'quantity': 2,
      },
    ],
    'Đã Mua': [
      {
        'name': 'Quần Jeans',
        'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
        'price': 250000,
        'quantity': 1,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentTab = _tabs[_selectedTab];
    final currentOrders = _demoOrders[currentTab]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Đơn hàng'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: currentOrders.isEmpty
                ? const Center(child: Text('Không có đơn hàng'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: currentOrders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderCard(currentOrders[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.grey[300],
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? Colors.deepPurple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? Colors.deepPurple : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> item) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Giá: đ${item['price']}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Text(
              'x${item['quantity']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
