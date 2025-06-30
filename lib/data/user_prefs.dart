import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart'; // Đường dẫn tới model User của bạn

Future<User?> loadUserFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('user');
  if (userJson != null) {
    return User.fromJson(jsonDecode(userJson));
  }
  return null;
}

Future<void> saveUserToPrefs(User user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', jsonEncode(user.toJson()));
  if (user.userId != null) {
    prefs.setInt('userid', user.userId!);
  }
}

Future<void> clearUserPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user'); // Xóa info user
  await prefs.remove('userid'); // Xóa userId nếu có
  // Nếu có lưu thêm 'cart', 'favorites'... thì cũng remove luôn
  await prefs.remove('cart');
  await prefs.remove('favorites');
}
