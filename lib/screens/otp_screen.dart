import 'package:clockee/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 6;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  int _secondsRemaining = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    _startCountdown();
  }

  void _startCountdown() {
    _canResend = false;
    _secondsRemaining = 30;
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _secondsRemaining--;
      });
      if (_secondsRemaining <= 0) {
        setState(() {
          _canResend = true;
        });
        return false;
      }
      return true;
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < otpLength - 1) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _onConfirm() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length < otpLength || otp.contains('')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập đầy đủ mã OTP')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );
    // Xử lý xác nhận OTP ở đây
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Mã OTP đã nhập: $otp')));
  }

  void _onResend() {
    if (_canResend) {
      // Xử lý gửi lại mã OTP ở đây
      _controllers.forEach((c) => c.clear());
      FocusScope.of(context).requestFocus(_focusNodes[0]);
      _startCountdown();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Mã OTP đã được gửi lại')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Nhập mã OTP'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Vui lòng nhập mã OTP gồm 6 chữ số đã được gửi đến email hoặc số điện thoại của bạn.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(otpLength, (index) {
                return SizedBox(
                  width: 45,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) => _onOtpChanged(value, index),
                  ),
                );
              }),
            ),
            SizedBox(height: 32),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: _canResend ? _onResend : null,
              child: Text(
                _canResend
                    ? 'Gửi lại mã OTP'
                    : 'Gửi lại mã sau $_secondsRemaining giây',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
