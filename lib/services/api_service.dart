import 'dart:convert';
import 'package:clockee/models/address.dart';
import 'package:clockee/models/bankinfomation.dart';
import 'package:clockee/models/cart.dart';
import 'package:clockee/models/order.dart';
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
  static Future<User?> login(String username, String password) async {
    final url = Uri.parse('http://103.77.243.218/api/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['User_id'] != null && data['Username'] == username) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', data['Username']);
        await prefs.setInt('userid', data['User_id']);

        return User.fromJson(data); // 👈 trả về user để gán ngoài
      }
    }

    return null;
  }

  //API ĐĂNG KÝ

  static Future<bool> registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://103.77.243.218/api/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': name,
          'phone': phone,
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

  // API: Thêm sản phẩm yêu thích
  static Future<bool> addFavoriteProduct({
    required int userId,
    required int productId,
  }) async {
    final url = Uri.parse('http://103.77.243.218/api/favorite');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId, 'product_id': productId}),
      );
      print("ma nguoi dung $userId, ma san pham $productId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Thêm yêu thích thành công');
        return true;
      } else {
        print(
          '❌ Lỗi thêm yêu thích: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      print('❌ Lỗi kết nối khi thêm yêu thích: $e');
      return false;
    }
  }

  //API XÓA YÊU THÍCH
  static Future<bool> removeFavoriteProduct({
    required int userId,
    required int productId,
  }) async {
    final url = Uri.parse('http://103.77.243.218/api/favorite');

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId, 'product_id': productId}),
      );
      print("ma nguoi dung $userId, ma san pham $productId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Xoa yêu thích thành công');
        return true;
      } else {
        print(
          '❌ Lỗi thêm yêu thích: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      print('❌ Lỗi kết nối khi thêm yêu thích: $e');
      return false;
    }
  }

  //API CHI TIET SAN PHAM
  static Future<Product> fetchProductDetail(int productId, int userId) async {
    final url = Uri.parse(
      'http://103.77.243.218/productdetail/$productId/$userId',
    );
    print('🔗 Đang gọi API chi tiết: $url');
    try {
      final response = await http.get(url);
      print('📥 Status code: ${response.statusCode}');
      print('📦 Body: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Nếu API trả về một object
        return Product.fromJson(data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Không thể lấy chi tiết sản phẩm: $e');
    }
  }

  //API GIỎ HÀNG
  static Future<List<CartItem>> fetchCartItem(int userId) async {
    final url = Uri.parse('http://103.77.243.218/orderitem/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => CartItem.fromJson(item)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  static Future<bool> addToCart(int userId, int productId) async {
    final url = Uri.parse('http://103.77.243.218/api/cart/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'User_id': userId, 'Product_id': productId}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Add to cart failed: ${response.body}');
      return false;
    }
  }

  static Future<bool> subtractFromCart(int userId, int productId) async {
    final url = Uri.parse('http://103.77.243.218/api/cart/subtract');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'User_id': userId, 'Product_id': productId}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Subtract from cart failed: ${response.body}');
      return false;
    }
  }

  //API XÓA GIỎ HÀNG
  static Future<bool> removeFromCart(int userId, int productId) async {
    final url = Uri.parse('http://103.77.243.218/api/cart/remove');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'User_id': userId, 'Product_id': productId}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Remove from cart failed: ${response.body}');
      return false;
    }
  }

  //API ĐỊA CHỈ
  static Future<List<Address>> fetchAddrress(int userId) async {
    final url = Uri.parse('http://103.77.243.218/receiveaddress/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = response.body.trim();

      if (body.isEmpty || body == 'null' || body == '{}') {
        return [];
      }

      final decoded = json.decode(body);

      if (decoded is List) {
        return decoded.map((e) => Address.fromJson(e)).toList();
      }
      if (decoded is Map && decoded['message'] != null) {
        return [];
      }
      return [];
    } else {
      print('Lỗi khi lấy địa chỉ: ${response.statusCode} - ${response.body}');
      throw Exception(
        'Lỗi khi lấy địa chỉ: ${response.statusCode} - ${response.body}',
      );
    }
  }

  //API THÊM ĐỊA CHỈ
  static Future<bool> addAddress(Address address) async {
    final url = Uri.parse('http://103.77.243.218/api/receiveaddress');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Thêm thành công
      return true;
    } else {
      print('Lỗi khi thêm địa chỉ: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

  //API SỬA ĐỊA CHỈ
  static Future<bool> editAddress(int id, Address address) async {
    final url = Uri.parse('http://103.77.243.218/api/receiveaddress/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(address.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(
        'Lỗi khi cập nhật địa chỉ: ${response.statusCode} - ${response.body}',
      );
      return false;
    }
  }
 static Future<ReturnOrder?> createOrder(int userId, int receiveId, int paymentMethod) async {
    final url = Uri.parse('http://103.77.243.218/api/createorder');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'User_id': userId,
          'Receive_id': receiveId,
          'Payment_method': paymentMethod,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ReturnOrder.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<BankInfomation?> fetchBankInfo() async {
  const url = 'http://103.77.243.218/bankinformation';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      return BankInfomation.fromJson(jsonData);
    } else {
      print('Lỗi server: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Lỗi khi gọi API: $e');
    return null;
  }
}
}

  
