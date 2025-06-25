// import 'package:flutter/material.dart';
// import 'package:iconify_design/iconify_design.dart';
// import '../services/api_service.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   String? selectedGender;

//   @override
//   Widget build(BuildContext context) {
//     final border = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(16),
//       borderSide: const BorderSide(color: Colors.grey),
//     );

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF3F3F3),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Container(
//                 height: 60,
//                 color: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const IconifyIcon(
//                         icon: 'material-symbols-light:arrow-back',
//                         size: 28,
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     const Text(
//                       'SỬA THÔNG TN TÀI KHOẢN',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   'THÔNG TIN CÁ NHÂN',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),

//               // Các TextField
//               _buildTextField(label: 'Họ Tên', border: border),
//               _buildTextField(label: 'Ngày Sinh', border: border),
//               _buildTextField(
//                 label: 'Số điện thoại',
//                 border: border,
//                 keyboardType: TextInputType.phone,
//               ),
//               _buildTextField(label: 'Email', border: border),
//               _buildGenderDropdown(
//                 border: border,
//                 selectedGender: selectedGender,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedGender = value;
//                   });
//                 },
//               ),

//               const SizedBox(height: 100),
//             ],
//           ),
//         ),

//         // Nút lưu
//         bottomNavigationBar: Container(
//           padding: const EdgeInsets.all(16),
//           color: const Color(0xFFF3F3F3),
//           child: SizedBox(
//             width: double.infinity,
//             height: 52,
//             child: ElevatedButton(
//               onPressed: () async {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: const Text(
//                 'LƯU THÔNG TIN',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildTextField({
//   required String label,
//   required OutlineInputBorder border,
//   TextInputType keyboardType = TextInputType.text,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//     child: TextField(
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         border: border,
//         focusedBorder: border.copyWith(
//           borderSide: const BorderSide(color: Colors.purple),
//         ),
//         enabledBorder: border,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 17,
//           vertical: 14,
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildGenderDropdown({
//   required OutlineInputBorder border,
//   required String? selectedGender,
//   required void Function(String?) onChanged,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//     child: ButtonTheme(
//       alignedDropdown: true, // Đảm bảo dropdown cùng chiều rộng
//       child: DropdownButtonFormField<String>(
//         value: selectedGender,
//         items: ['Nam', 'Nữ'].map((String gender) {
//           return DropdownMenuItem<String>(value: gender, child: Text(gender));
//         }).toList(),
//         onChanged: (value) {},
//         decoration: InputDecoration(
//           focusedBorder: border.copyWith(
//             borderSide: const BorderSide(color: Colors.purple),
//           ),
//           labelText: 'Giới Tính',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 17,
//             vertical: 14,
//           ),
//         ),
//         dropdownColor: Colors.white, // Màu dropdown
//       ),
//     ),
//   );
// }
