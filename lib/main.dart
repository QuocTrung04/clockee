import 'package:clockee/data/data.dart';
import 'package:clockee/widgets/custom_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appData = AppData();
  await appData.loadUserFromLocal();
  await appData.loadCart();

  runApp(
    ChangeNotifierProvider.value(
      value: appData, // Dùng chính instance đã load dữ liệu
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
