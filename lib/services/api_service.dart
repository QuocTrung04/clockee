import 'dart:convert';
import 'dart:io';
import 'package:clockee/models/sanpham.dart';
import 'package:clockee/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //API DANH SẢN PHẨM
  static Future<List<Product>> fetchProducts(int userId) async {
    final url = Uri.parse('http://103.77.243.218/product/$userId');

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

      if (data['User_id'] != null && data['Username'] == username) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', data['Username']);
        await prefs.setInt('userid', data['User_id']);
        return true;
      } else {
        return false;
      }
    } else {
      print('sai tài khoản hoặc mật khẩu');
      return false;
    }
  }

  //API ĐĂNG KÝ
  static const String baseUrl = 'http://103.77.243.218/api/register';

  static Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Đăng ký thành công: ${response.body}');
        return true;
      } else {
        print('Đăng ký thất bại: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Lỗi khi gọi API đăng ký: $e');
      return false;
    }
  }

  //API DANH SÁCH YÊU THÍCH

  static Future<List<Product>> fetchFavoriteProducts(int userId) async {
    final url = Uri.parse('http://103.77.243.218/favorite/$userId');
    print('🔗 Đang gọi API: $url');

    try {
      final response = await http.get(url);
      print('📥 Status code: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Không thể lấy danh sách yêu thích: $e');
    }
  }
  // API EDIT PROFILE

  // GET user info
  static Future<User> fetchUser(int userId) async {
    final resp = await http.get(
      Uri.parse('http://103.77.243.218/user/$userId'),
    );
    if (resp.statusCode == 200) {
      final decoded = json.decode(resp.body);

      if (decoded is List) {
        if (decoded.isNotEmpty) {
          return User.fromJson(decoded.first as Map<String, dynamic>);
        }
        throw Exception('Empty user list');
      } else if (decoded is Map<String, dynamic>) {
        return User.fromJson(decoded);
      } else {
        throw Exception('Unexpected response format');
      }
    }
    throw Exception('HTTP ${resp.statusCode}');
  }

  //API UPDATE USER
  static Future<void> updateUser(
    int userId, {
    required String name,
    required String email,
    required String phone,
    required DateTime birthday,
    required int sex,
  }) async {
    final url = Uri.parse('http://103.77.243.218/api/user/$userId');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Email': email,
        'Phone': phone,
        'Birthday':
            "${birthday.year}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        'Sex': sex,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Cập nhật thất bại: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
