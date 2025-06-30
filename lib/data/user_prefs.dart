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
