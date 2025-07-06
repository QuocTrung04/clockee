// import 'package:flutter/material.dart';

// class OrderScreen extends StatefulWidget {
//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   int _selectedTab = 0;

//   final List<String> _tabs = [
//     'Chờ xác nhận',
//     'Đang vận chuyển',
//     'Đã mua',
//     'Đã hủy',
//   ];

//   final Map<String, List<Map<String, dynamic>>> _demoOrders = {
//     'Chờ xác nhận': [
//       {
//         'name': 'Giày Thể Thao',
//         'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
//         'price': 200000,
//         'quantity': 1,
//       },
//       {
//         'name': 'Giày Thể Thao',
//         'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
//         'price': 200000,
//         'quantity': 1,
//       },
//       {
//         'name': 'Giày Thể Thao',
//         'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
//         'price': 200000,
//         'quantity': 1,
//       },
//     ],
//     'Đang vận chuyển': [
//       {
//         'name': 'Áo Hoodie',
//         'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
//         'price': 150000,
//         'quantity': 2,
//       },
//     ],
//     'Đã Mua': [
//       {
//         'name': 'Quần Jeans',
//         'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
//         'price': 250000,
//         'quantity': 1,
//       },
//     ],
//     'Đã hủy': [
//       {
//         'name': 'Quần Jeans',
//         'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
//         'price': 250000,
//         'quantity': 1,
//       },
//     ],
//   };

//   @override
//   Widget build(BuildContext context) {
//     final currentTab = _tabs[_selectedTab];
//     final currentOrders = _demoOrders[currentTab]!;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         title: const Text('Đơn hàng'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0.5,
//         leading: const BackButton(),
//       ),
//       body: Column(
//         children: [
//           _buildTabBar(),
//           Expanded(
//             child: currentOrders.isEmpty
//                 ? const Center(child: Text('Không có đơn hàng'))
//                 : ListView.builder(
//                     padding: const EdgeInsets.all(12),
//                     itemCount: currentOrders.length,
//                     itemBuilder: (context, index) {
//                       return _buildOrderCard(currentOrders[index]);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildTabBar() {
//   //   return Container(
//   //     color: Colors.grey[300],
//   //     child: Row(
//   //       children: List.generate(_tabs.length, (index) {
//   //         final isSelected = _selectedTab == index;
//   //         return Expanded(
//   //           child: GestureDetector(
//   //             onTap: () => setState(() => _selectedTab = index),
//   //             child: Container(
//   //               padding: const EdgeInsets.symmetric(vertical: 14),
//   //               alignment: Alignment.center,
//   //               decoration: BoxDecoration(
//   //                 color: isSelected ? Colors.white : Colors.grey[300],
//   //                 border: Border(
//   //                   bottom: BorderSide(
//   //                     color: isSelected
//   //                         ? Colors.deepPurple
//   //                         : Colors.transparent,
//   //                     width: 2,
//   //                   ),
//   //                 ),
//   //               ),
//   //               child: Text(
//   //                 _tabs[index],
//   //                 style: TextStyle(
//   //                   fontWeight: isSelected
//   //                       ? FontWeight.bold
//   //                       : FontWeight.normal,
//   //                   color: isSelected ? Colors.deepPurple : Colors.black,
//   //                   fontSize: 15,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         );
//   //       }),
//   //     ),
//   //   );
//   // }

//   Widget _buildTabBar() {
//     return Container(
//       color: Colors.grey[300],
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         physics: BouncingScrollPhysics(),
//         child: Row(
//           children: List.generate(_tabs.length, (index) {
//             final isSelected = _selectedTab == index;
//             return GestureDetector(
//               onTap: () => setState(() => _selectedTab = index),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 12),
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 8,
//                   horizontal: 20,
//                 ),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.white : Colors.grey[300],
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: isSelected ? Colors.deepPurple : Colors.transparent,
//                     width: 2,
//                   ),
//                 ),
//                 child: Text(
//                   _tabs[index],
//                   style: TextStyle(
//                     fontWeight: isSelected
//                         ? FontWeight.bold
//                         : FontWeight.normal,
//                     color: isSelected ? Colors.deepPurple : Colors.black,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderCard(Map<String, dynamic> item) {
//     return Card(
//       color: Colors.white,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 item['image'],
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item['name'],
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Giá: đ${item['price']}',
//                     style: TextStyle(color: Colors.grey[700]),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               'x${item['quantity']}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// Giả sử bạn có model Order (bạn có thể tùy chỉnh theo API thật)
class Order {
  final String name;
  final String image;
  final int price;
  final int quantity;

  Order({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  // Tạo từ JSON nếu API trả về JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedTab = 0;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _tabs = [
    'Chờ xác nhận',
    'Đang vận chuyển',
    'Đã mua',
    'Đã hủy',
  ];

  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _orders = [];
    });

    final status = _tabs[_selectedTab];

    try {
      // TODO: Thay đoạn này bằng gọi API thật
      // Ví dụ giả lập call API delay 2s rồi trả data
      await Future.delayed(Duration(seconds: 2));

      // Giả lập dữ liệu nhận về
      final List<Map<String, dynamic>> responseData = [
        {
          'name': 'Giày Thể Thao',
          'image': 'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
          'price': 200000,
          'quantity': 1,
        },
        // ... bạn có thể tạo thêm item hoặc thay đổi theo status
      ];

      // Chuyển dữ liệu JSON sang List<Order>
      final orders = responseData.map((e) => Order.fromJson(e)).toList();

      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi khi tải đơn hàng: $e';
        _isLoading = false;
      });
    }
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
    _fetchOrders();
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

  // Widget _buildTabBar() {
  //   return Container(
  //     color: Colors.grey[300],
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       physics: BouncingScrollPhysics(),
  //       child: Row(
  //         children: List.generate(_tabs.length, (index) {
  //           final isSelected = _selectedTab == index;
  //           return GestureDetector(
  //             onTap: () => _onTabChanged(index),
  //             child: Container(
  //               margin: const EdgeInsets.symmetric(horizontal: 12),
  //               padding: const EdgeInsets.symmetric(
  //                 vertical: 8,
  //                 horizontal: 20,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: isSelected ? Colors.white : Colors.grey[300],
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Text(
  //                 _tabs[index],
  //                 style: TextStyle(
  //                   fontWeight: isSelected
  //                       ? FontWeight.bold
  //                       : FontWeight.normal,
  //                   color: isSelected ? Colors.deepPurple : Colors.black,
  //                   fontSize: 15,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  // }
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
                order.image,
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
                    order.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Giá: đ${order.price}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Text(
              'x${order.quantity}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
