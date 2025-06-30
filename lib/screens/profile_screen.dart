import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/models/user.dart';
import 'package:clockee/screens/change_password_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdayController = TextEditingController();
  int? _selectedGender;

  User? _user;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  Future<void> _fetchUser() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('userid');
      if (id == null) throw Exception('No user id');
      final user = await ApiService.fetchUser(id);
      if (!mounted) return;
      setState(() {
        _user = user;
        _nameController.text = user.name ?? "";
        _emailController.text = user.email ?? "";
        _phoneController.text = user.phone ?? "";
        _birthdayController.text = user.birthday != null
            ? formatDate(user.birthday!)
            : '';

        _selectedGender = user.sex;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppData>(context).user;
    if (_loading) {
      return _buildScaffold(Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return _buildScaffold(Center(child: Text('Lỗi: $_error')));
    }
    return _buildScaffold(
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hi, ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  _user!.userName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Tài Khoản',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInfoTextField('Họ Tên', _nameController),
                    _buildInfoTextField('Số Điện Thoại', _phoneController),
                    _buildInfoTextField('Email', _emailController),
                    _buildInfoTextField('Ngày Sinh', _birthdayController),
                    _buildGenderDropdown(),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final birthday = DateTime.parse(
                                  _birthdayController.text,
                                );

                                await ApiService.updateUser(
                                  _user!.userId,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  birthday: DateTime.parse(
                                    _birthdayController.text,
                                  ),
                                  sex: _selectedGender ?? 1,
                                );
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Cập nhật thành công'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                _fetchUser();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Cập nhật thất bại'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                print('$e');
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                            ),
                            child: Text('Cập nhật'),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                            ),
                            child: Text('Đổi mật khẩu'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold _buildScaffold(Widget body) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: IconifyIcon(icon: 'material-symbols-light:arrow-back'),
        ),
        title: Text('Thông tin cá nhân'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: body,
    );
  }

  String formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildInfoTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: controller.text.isEmpty ? 'Nhập $label...' : null,
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới Tính',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        DropdownButton<int>(
          value: _selectedGender,
          hint: Text('Chọn giới tính'), // Hiển thị nếu giá trị null
          items: [
            DropdownMenuItem(child: Text("Nam"), value: 1),
            DropdownMenuItem(child: Text("Nữ"), value: 0),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
            print('Đây là giới tính: $_selectedGender');
          },
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
