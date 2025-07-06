import 'package:clockee/data/data.dart';
import 'package:clockee/models/order.dart';
import 'package:clockee/models/user.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedTab = 0;
  bool _isLoading = false;
  String? _errorMessage;
  List<Order> _orders = [];
  User? userData = null;

  final List<String> _tabs = [
    'Chờ xác nhận',
    'Đang vận chuyển',
    'Đã mua',
    'Đã hủy',
  ];

  void loadOrders(int userId) async {
    try {
      _orders = await ApiService.fetchOrders(userId);
    } catch (e) {
      print('Lỗi khi tải đơn hàng: $e');
    }
  }

  @override
  void initState() {
    
    super.initState();
    // _fetchOrders();
    
  }

  

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
    // _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<AppData>(context, listen: false).user;
    loadOrders(userData!.userId);
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : _orders.isEmpty
                ? const Center(child: Text('Không có đơn hàng'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return _buildOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.grey[200], // nền tổng thể
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final isSelected = _selectedTab == index;
            return GestureDetector(
              onTap: () => _onTabChanged(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Colors.deepPurple
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.deepPurple,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
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
                order.items[0].imageUrl,
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
                    order.items[0].productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Giá: đ${order.items[0].sellPrice}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Text(
              'x${order.items[0].quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
