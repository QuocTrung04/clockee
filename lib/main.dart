import 'package:clockee/screens/account_information_screen.dart';
import 'package:clockee/screens/account_screen.dart';
import 'package:clockee/widgets/custom_main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: CustomMainScreen()),
    );
  }
}
