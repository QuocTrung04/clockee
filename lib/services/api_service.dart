import 'dart:convert';
import 'package:clockee/models/sanpham.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //API DANH SẢN PHẨM
  static Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('http://103.77.243.218/product');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  //API ĐĂNG NHẬP
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('http://103.77.243.218/api/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // ✅ Kiểm tra xem có thông tin người dùng hay không
      if (data['User_id'] != null && data['Username'] == username) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        return true;
      } else {
        return false;
      }
    } else {
      print('sai tài khoản hoặc mật khẩu');
      return false;
    }
  }
}
