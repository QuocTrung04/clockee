import 'package:clockee/screens/account_information_screen.dart';
import 'package:clockee/screens/account_screen.dart';
import 'package:clockee/data/data.dart';
import 'package:clockee/screens/order_screen.dart';
import 'package:clockee/screens/pay_screen.dart';
import 'package:clockee/widgets/custom_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MyApp(),
    ),
  );
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
