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
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      List<Order> orders = await ApiService.fetchOrders(userId);
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Lỗi khi tải đơn hàng: $e';
      });
    }
  }

  @override
  void initState() {
    
    super.initState();
    // _fetchOrders();
    
    userData = Provider.of<AppData>(context, listen: false).user;
    loadOrders(userData!.userId);
    _selectedTab = 0;
  }

  

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
    // _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {

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
    if (order.orderStatus != _selectedTab) {
      return SizedBox.shrink();
    }
    
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 6, 10, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    order.items[0].imageUrl,
                    width: 60,
                    height: 60,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                          Container(
                            width: 150,
                            child: Text(
                              order.items[0].productName,
                              maxLines: 1,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          Text(_tabs[order.orderStatus], style: TextStyle(fontSize: 11)),
                      ],),
                      
                      Row(
                        children: [
                          Text(
                            order.items[0].watch_model,
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Text('x${order.items[0].quantity}', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'đ${_formatCurrency(order.items[0].actualPrice)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'đ${_formatCurrency(order.items[0].sellPrice)}',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Tổng số tiền: đ${_formatCurrency(order.totalPrice)}')],
            ),
          ],
        ),
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
