import 'dart:convert';

import 'package:clockee/screens/home_screen.dart';
import 'package:clockee/screens/register_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:clockee/data/data.dart';
import 'package:clockee/widgets/custom_main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _StateLoginScreen();
}

class _StateLoginScreen extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp validPassword = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{1,6}$',
  );
  final RegExp validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  bool isLoggedIn = false;
  bool _obscure = true;

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
                padding: const EdgeInsets.all(10),
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
                            'ĐĂNG NHẬP',
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
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          hintText: "Tài khoản",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                          prefixIcon: Padding(
                                            padding: EdgeInsetsGeometry.all(10),
                                            child: IconifyIcon(
                                              icon: 'mdi-light:account',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(),
                                      child: TextField(
                                        obscureText: _obscure,
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          hintText: "Mật khẩu",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscure = !_obscure;
                                              });
                                            },
                                            icon: IconifyIcon(
                                              icon: _obscure
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
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Quên mật khẩu?',
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Tạo tài khoản',
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              SizedBox(
                                width: 230,
                                height: 50,
                                child: GestureDetector(
                                  onTap: () async {
                                    final username = _usernameController.text
                                        .trim();
                                    final password = _passwordController.text
                                        .trim();

                                    if (username.isEmpty || password.isEmpty) {
                                      setState(() {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Vui lòng nhập đầy đủ thông tin',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                                      return;
                                    }

                                    final userLogin = await ApiService.login(
                                      username,
                                      password,
                                    );

                                    if (!mounted) return;

                                    if (userLogin != null) {
                                      
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString("UserInfo", jsonEncode(userLogin.toJson()));
                                      await prefs.setBool('isLoggedIn', true);
                                      Provider.of<AppData>(context, listen: false).setUser(userLogin);
                                      if (!mounted) return;

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CustomMainScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Tài khoản hoặc mật khẩu sai',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                                    }
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
                                      'Đăng nhập',
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
