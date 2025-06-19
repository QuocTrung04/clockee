// import 'package:clockee/models/sanpham.dart';
// import 'package:flutter/material.dart';
// import 'package:iconify_design/iconify_design.dart';

// class ProductDetailScreen extends StatelessWidget {
//   final SanPham sanpham;
//   const ProductDetailScreen({super.key, required this.sanpham});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 // Ảnh sản phẩm
//                 Image.network(
//                   sanpham.imageUrl,
//                   width: double.infinity,
//                   height: 300,
//                   fit: BoxFit.contain,
//                 ),

//                 // Nút quay lại
//                 Positioned(
//                   top: 16,
//                   left: 16,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white70,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ),

//                 // Nút yêu thích
//                 Positioned(
//                   top: 16,
//                   right: 60,
//                   child: GestureDetector(
//                     onTap: () {
//                       print('them yeu thich');
//                     },
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         boxShadow: sanpham.yeuThich
//                             ? [
//                                 BoxShadow(
//                                   color: Colors.purple.shade100,
//                                   blurRadius: 8,
//                                   spreadRadius: 2,
//                                 ),
//                               ]
//                             : [],
//                       ),
//                       child: AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 300),
//                         transitionBuilder: (child, animation) {
//                           return ScaleTransition(
//                             scale: animation,
//                             child: child,
//                           );
//                         },
//                         child: IconifyIcon(
//                           key: ValueKey(sanpham.yeuThich),
//                           icon: sanpham.yeuThich
//                               ? 'iconoir:heart-solid'
//                               : 'iconoir:heart',
//                           color: const Color(0xFF662D91),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Nút giỏ hàng
//                 Positioned(
//                   top: 16,
//                   right: 16,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white70,
//                     child: IconButton(
//                       icon: IconifyIcon(
//                         icon: 'solar:cart-bold',
//                         color: Color(0xFF662D91),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Nội dung chi tiết
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         sanpham.tenSanPham,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${_formatCurrency(sanpham.donGia)}₫',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                     const SizedBox(height: 8),

//                     // Đánh giá
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ...List.generate(
//                           5,
//                           (index) => const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         const Text(
//                           '(41)',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // Thông số kỹ thuật
//                     const Divider(),
//                     const InfoRow(label: 'Mã sản phẩm:', value: 'RE-AU0605L'),
//                     const InfoRow(label: 'Thương hiệu:', value: 'Orient Star'),
//                     const InfoRow(label: 'Giới tính:', value: 'Nam'),
//                     const InfoRow(label: 'Loại đồng hồ:', value: 'Đồng hồ cơ'),
//                     const InfoRow(label: 'Kích thước mặt:', value: '39.3 mm'),
//                     const SizedBox(height: 16),

//                     // Mô tả
//                     const Text(
//                       'Mẫu đồng hồ đáng chú ý nằm trong bộ sưu tập đồng hồ giới hạn đặc biệt Orient Vietnam Special Edition 2023 - thiết kế nam tính.',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 80),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       // Nút Mua Ngay
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton(
//             onPressed: () {
//               // Xử lý mua hàng
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepPurple,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'Mua ngay',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatCurrency(int price) {
//     return price.toString().replaceAllMapped(
//       RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//       (match) => '${match[1]}.',
//     );
//   }
// }

// class InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const InfoRow({super.key, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//           const SizedBox(width: 4),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }
