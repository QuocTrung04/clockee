import 'package:clockee/screens/otp_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({super.key});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onConfirm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      int responsecode = await ApiService.sendOtp(email);
      if(responsecode == 200){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(email: email,)),
        );
      }
      else if(responsecode == 404){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email không tồn tại trong hệ thống')),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể gửi mã OTP tới $email')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: IconifyIcon(icon: 'material-symbols-light:arrow-back'),
          ),
          title: Text("Xác nhận email"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vui lòng nhập email của bạn để xác nhận đặt lại mật khẩu.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    // Kiểm tra định dạng email đơn giản
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white, // màu chữ
                    ),
                    onPressed: _onConfirm,
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
}
