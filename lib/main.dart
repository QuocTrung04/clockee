import 'package:clockee/screens/account_information_screen.dart';
import 'package:clockee/screens/account_screen.dart';
import 'package:clockee/screens/order_screen.dart';
import 'package:clockee/screens/pay_screen.dart';
import 'package:clockee/widgets/custom_main_screen.dart';
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
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
      navigatorObservers: [routeObserver],
    );
  }
}
