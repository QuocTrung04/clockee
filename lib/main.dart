import 'package:clockee/screens/add_adress_screen.dart';
import 'package:clockee/screens/edit_adress_screen.dart';
import 'package:clockee/screens/product_details_screen.dart';
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
