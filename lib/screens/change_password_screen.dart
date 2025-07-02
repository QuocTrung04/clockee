import 'package:clockee/data/data.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _StateLoginScreen();
}

class _StateLoginScreen extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obsOldPassword = true;
  bool _obsNewPassword = true;
  bool _obsCorfimPassword = true;

  void _changPassword() async {
    final result = await Provider.of<AppData>(context, listen: false)
        .changePassword(
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
    print('oldpassword ${_oldPasswordController.text}');
    print('newpassword ${_newPasswordController.text}');
    if (!mounted) return;
    final isSuccess = result == 'Đổi mật khẩu thành công';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
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
                            'ĐỔI MẬT KHẨU',
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
                                      decoration: BoxDecoration(),
                                      child: TextField(
                                        controller: _oldPasswordController,
                                        obscureText: _obsOldPassword,
                                        decoration: InputDecoration(
                                          hintText: "Mật khẩu cũ",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obsOldPassword =
                                                    !_obsOldPassword;
                                              });
                                            },
                                            icon: IconifyIcon(
                                              icon: _obsOldPassword
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
                                      decoration: BoxDecoration(),
                                      child: TextField(
                                        controller: _newPasswordController,
                                        obscureText: _obsNewPassword,
                                        decoration: InputDecoration(
                                          hintText: "Mật khẩu mới",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obsNewPassword =
                                                    !_obsNewPassword;
                                              });
                                            },
                                            icon: IconifyIcon(
                                              icon: _obsNewPassword
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
                                      decoration: BoxDecoration(),
                                      child: TextField(
                                        controller: _confirmPasswordController,
                                        obscureText: _obsCorfimPassword,
                                        decoration: InputDecoration(
                                          hintText: "Nhập lại mật khẩu mới",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obsCorfimPassword =
                                                    !_obsCorfimPassword;
                                              });
                                            },
                                            icon: IconifyIcon(
                                              icon: _obsCorfimPassword
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
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: Text(
                                    'Quên mật khẩu',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              Align(alignment: Alignment.centerLeft),
                              SizedBox(height: 40),
                              SizedBox(
                                width: 230,
                                height: 50,
                                child: GestureDetector(
                                  onTap: () {
                                    _changPassword();
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
                                      'Đổi mật khẩu',
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
