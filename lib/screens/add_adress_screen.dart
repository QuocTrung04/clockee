import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';

class AddAdressScreen extends StatefulWidget {
  const AddAdressScreen({super.key});

  @override
  State<AddAdressScreen> createState() => _AddAdressScreenState();
}

class _AddAdressScreenState extends State<AddAdressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _communeController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  bool _isDefault = false;

  void _addAddress() async {
    final userId =
        Provider.of<AppData>(context, listen: false).user?.userId ?? 0;
    Address newAddress = Address(
      userId: userId,
      name: _nameController.text,
      phone: _phoneController.text,
      province: _provinceController.text,
      commune: _communeController.text,
      district: _districtController.text,
      street: _streetController.text,
      addressDetail: _detailController.text,
    );
    bool result = await ApiService.addAddress(newAddress);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thêm địa chỉ thành công'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi thêm địa chỉ'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  'THÊM ĐỊA CHỈ MỚI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Các TextField
              _buildTextField(
                label: 'Tên',
                border: border,
                controller: _nameController,
              ),
              _buildTextField(
                label: 'Số điện thoại',
                border: border,
                keyboardType: TextInputType.phone,
                controller: _phoneController,
              ),
              _buildTextField(
                label: 'Tỉnh/Thành Phố',
                border: border,
                controller: _provinceController,
              ),
              _buildTextField(
                label: 'Quận/Huyện',
                border: border,
                controller: _districtController,
              ),
              _buildTextField(
                label: 'Phường/Xã',
                border: border,
                controller: _communeController,
              ),
              _buildTextField(
                label: 'Đường',
                border: border,
                controller: _streetController,
              ),
              _buildTextField(
                label: 'Địa chỉ chi tiết',
                border: border,
                controller: _detailController,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Đặt làm địa chỉ mặc định',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Switch(
                      value: _isDefault,
                      onChanged: (val) {
                        setState(() {
                          _isDefault = val;
                        });
                      },
                      activeColor: Color(0xFF662D91),
                    ),
                  ],
                ),
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
            child: ElevatedButton(
              onPressed: () {
                _addAddress();
              },
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
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField({
  required String label,
  required OutlineInputBorder border,
  required TextEditingController controller,
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
