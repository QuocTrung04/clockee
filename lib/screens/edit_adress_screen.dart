import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController _communeController;
  late TextEditingController _streetController;
  late TextEditingController _addressDetailController;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.address.name);
    _phoneController = TextEditingController(text: widget.address.phone);
    _provinceController = TextEditingController(text: widget.address.province);
    _districtController = TextEditingController(text: widget.address.district);
    _communeController = TextEditingController(text: widget.address.commune);
    _streetController = TextEditingController(text: widget.address.street);
    _addressDetailController = TextEditingController(
      text: widget.address.addressDetail,
    );
    _isDefault = widget.address.isDefault;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _communeController.dispose();
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
                      'Sửa Địa Chỉ',
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
                controller: _communeController,
                label: 'Phường/Xã',
                border: border,
              ),
              _buildTextField(
                controller: _streetController,
                label: 'Đường',
                border: border,
              ),
              _buildTextField(
                controller: _addressDetailController,
                label: 'Địa chỉ chi tiết',
                border: border,
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
                  onPressed: () async {
                    Address updatedAddress = Address(
                      receiveid: widget.address.receiveid,
                      userId: widget.address.userId,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      province: _provinceController.text,
                      commune: _communeController.text,
                      district: _districtController.text,
                      street: _streetController.text,
                      addressDetail: _addressDetailController.text,
                      isDefault: _isDefault,
                    );
                    final success = await Provider.of<AppData>(
                      context,
                      listen: false,
                    ).updateAddress(updatedAddress);
                    if (!mounted) return;
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Cập nhật địa chỉ thành công!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Cập nhật địa chỉ thất bại!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'CẬP NHẬT',
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
