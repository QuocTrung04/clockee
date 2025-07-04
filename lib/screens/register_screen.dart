import 'package:clockee/screens/login_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconify_design/iconify_design.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _StateRegisterScreen();
}

class _StateRegisterScreen extends State<RegisterScreen> {
  bool _password = true;
  bool _confirmpassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _corfirmPasswordController =
      TextEditingController();
  Future<void> _dangKy() async {
    if (_passwordController.text != _corfirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mật khẩu không khớp'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (_nameController.text.contains(RegExp(r'\s'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tài khoản không được chứa khoảng trống trống'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _corfirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final success = await ApiService.registerUser(
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (!mounted) {
      return;
    }
    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thành công'),
          content: Text('Đăng ký thành công! Vui lòng đăng nhập.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // đóng dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Đồng ý'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thất bại'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.purple.shade700,
                Colors.purple.shade500,
                Colors.purple.shade300,
                Colors.purple.shade200,
              ],
            ),
          ),

          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: IconifyIcon(
                    icon: 'bitcoin-icons:arrow-left-outline',
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FadeInDown(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ĐĂNG KÝ',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Welcome',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeInUp(
                      delay: Duration(milliseconds: 300),
                      duration: Duration(seconds: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 60),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.shade100,
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            hintText: "Tài khoản",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            prefixIcon: Padding(
                                              padding: EdgeInsetsGeometry.all(
                                                10,
                                              ),
                                              child: IconifyIcon(
                                                icon: 'mdi-light:account',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            prefixIcon: Padding(
                                              padding: EdgeInsetsGeometry.all(
                                                10,
                                              ),
                                              child: IconifyIcon(
                                                icon: 'mdi-light:email',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _phoneController,
                                          decoration: InputDecoration(
                                            hintText: "Số điện thoại",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            prefixIcon: Padding(
                                              padding: EdgeInsetsGeometry.all(
                                                10,
                                              ),
                                              child: IconifyIcon(
                                                icon: 'mdi-light:phone',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          controller: _passwordController,
                                          obscureText: _password,
                                          decoration: InputDecoration(
                                            hintText: "Mật khẩu",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _password = !_password;
                                                });
                                              },
                                              icon: IconifyIcon(
                                                icon: _password
                                                    ? 'iconoir:eye-closed'
                                                    : 'iconoir:eye',
                                              ),
                                            ),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: IconifyIcon(
                                                icon: 'arcticons:nc-passwords',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextField(
                                          controller:
                                              _corfirmPasswordController,
                                          obscureText: _confirmpassword,
                                          decoration: InputDecoration(
                                            hintText: "Nhập lại mật khẩu",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _confirmpassword =
                                                      !_confirmpassword;
                                                });
                                              },
                                              icon: IconifyIcon(
                                                icon: _confirmpassword
                                                    ? 'iconoir:eye-closed'
                                                    : 'iconoir:eye',
                                              ),
                                            ),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: IconifyIcon(
                                                icon: 'arcticons:nc-passwords',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    child: Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),

                                SizedBox(
                                  width: 230,
                                  height: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      _dangKy();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          colors: [Colors.purple, Colors.pink],
                                        ),
                                      ),
                                      child: Text(
                                        'Đăng ký',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
