import 'package:clockee/models/address.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class EditAdressScreen extends StatefulWidget {
  final Address address;
  const EditAdressScreen({super.key, required this.address});

  @override
  State<EditAdressScreen> createState() => _EditAdressScreenState();
}

class _EditAdressScreenState extends State<EditAdressScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _provinceController;
  late TextEditingController _districtController;
  late TextEditingController _wardsController;
  late TextEditingController _streetController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.address.name);
    _phoneController = TextEditingController(text: widget.address.phone);
    _provinceController = TextEditingController(text: widget.address.province);
    _districtController = TextEditingController(text: widget.address.district);
    _wardsController = TextEditingController(text: widget.address.wards);
    _streetController = TextEditingController(text: widget.address.street);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _wardsController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                height: 60,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const IconifyIcon(
                        icon: 'material-symbols-light:arrow-back',
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Thêm Địa Chỉ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'SỬA ĐỊA CHỈ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Các TextField
              _buildTextField(
                controller: _nameController,
                label: "Tên",
                border: border,
              ),
              _buildTextField(
                controller: _phoneController,
                label: 'Số điện thoại',
                border: border,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: _provinceController,
                label: 'Tỉnh/Thành Phố',
                border: border,
              ),
              _buildTextField(
                controller: _districtController,
                label: 'Quận/Huyện',
                border: border,
              ),
              _buildTextField(
                controller: _wardsController,
                label: 'Phường/Xã',
                border: border,
              ),
              _buildTextField(
                controller: _streetController,
                label: 'Đường',
                border: border,
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),

        // Nút lưu
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFFF3F3F3),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'XÓA ĐỊA CHỈ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'LƯU ĐỊA CHỈ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required OutlineInputBorder border,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.purple),
          ),
          enabledBorder: border,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
