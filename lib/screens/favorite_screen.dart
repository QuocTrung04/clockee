// import 'package:clockee/data/data.dart';
// import 'package:flutter/material.dart';
// // import 'package:clockee/data/data.dart';
// import 'package:clockee/models/sanpham.dart';
// import 'package:iconify_design/iconify_design.dart';

// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key});
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final sanPhamYeuThich = sanpham.where((sp) => sp.yeuThich).toList();
//     if (sanPhamYeuThich.isEmpty) {
//       return const Center(
//         child: Text(
//           'Không có sản phẩm yêu thích',
//           style: TextStyle(
//             fontSize: 20,
//             color: Color(0xFF662D91),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
//     }
//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: sanPhamYeuThich.length,
//       itemBuilder: (context, index) {
//         return SanPhamWidget(sanPham: sanPhamYeuThich[index]);
//       },
//     );
//   }
// }

// class SanPhamWidget extends StatefulWidget {
//   final SanPham sanPham;

//   const SanPhamWidget({super.key, required this.sanPham});

//   @override
//   State<SanPhamWidget> createState() => _SanPhamWidgetState();
// }

// class _SanPhamWidgetState extends State<SanPhamWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color(0xFFFFFFFF),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.2,
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: Image.network(
//                     widget.sanPham.imageUrl,
//                     width: double.infinity,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () {
//                       widget.sanPham.yeuThich = !widget.sanPham.yeuThich;
//                       print('xoa khoi yeu thich');
//                     },
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         boxShadow: widget.sanPham.yeuThich
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
//                           key: ValueKey(widget.sanPham.yeuThich),
//                           icon: widget.sanPham.yeuThich
//                               ? 'iconoir:heart-solid'
//                               : 'iconoir:heart',
//                           color: const Color(0xFF662D91),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             widget.sanPham.tenSanPham,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             widget.sanPham.maSanPham,
//             style: const TextStyle(
//               color: Color(0xFF662D91),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             widget.sanPham.moTa,
//             style: const TextStyle(fontSize: 12, color: Color(0xFF662D91)),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Giá ${_formatCurrency(widget.sanPham.donGia)}đ',
//             style: const TextStyle(
//               color: Color(0xFF662D91),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF662D91),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: const Text('Thêm Vào Giỏ'),
//             ),
//           ),
//         ],
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
