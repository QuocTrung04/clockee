import 'dart:convert';

import 'package:clockee/data/user_prefs.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/models/order.dart';
import 'package:clockee/models/user.dart';
import 'package:clockee/models/cart.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  User? _user;
  List<CartItem> _cartItems = [];
  List<Address> _addresses = [];
  ReturnOrder? _returnOrder;

  User? get user => _user;
  List<CartItem> get cartItems => _cartItems;
  List<Address> get addresses => _addresses;
  ReturnOrder? get returnOrder => _returnOrder;

  Future<void> initUser() async {
    _user = await loadUserFromPrefs();
    notifyListeners();
  }

  void setUser(User user) async {
    _user = user;
    await saveUserToPrefs(user);
    notifyListeners(); // Cập nhật cho tất cả listener
  }

  void setCart(List<CartItem> items) {
    _cartItems = items;
    notifyListeners();
  }

  void setReturnOrder(ReturnOrder returnOrder) {
    _returnOrder = returnOrder;
    notifyListeners();
  }

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  Future<void> loadUserFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      _user = User.fromJson(userMap);
      setUser(_user!);
      notifyListeners();
    }
  }

  Future<void> loadCart() async {
    if (_user != null) {
      final listCart = await ApiService.fetchCartItem(_user!.userId!);
      setCart(listCart);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await clearUserPrefs(); // Xóa local
    _user = null;
    _cartItems.clear(); // Xóa giỏ hàng
    notifyListeners();
  }

  Future<void> fetchAddressList(int userId) async {
    final fetchedList = await ApiService.fetchAddrress(userId);
    _addresses = fetchedList;
    notifyListeners();
  }

  Future<bool> updateAddress(Address updatedAddress) async {
    final success = await ApiService.editAddress(
      updatedAddress.receiveid!,
      updatedAddress,
    );

    if (success) {
      // Nếu update thành mặc định thì set các địa chỉ khác về không mặc định
      if (updatedAddress.isDefault) {
        _addresses = _addresses.map((a) {
          if (a.receiveid == updatedAddress.receiveid) {
            return updatedAddress;
          } else if (a.isDefault) {
            return a.copyWith(isDefault: false);
          }
          return a;
        }).toList();
      } else {
        final idx = _addresses.indexWhere(
          (a) => a.receiveid == updatedAddress.receiveid,
        );
        if (idx != -1) {
          _addresses[idx] = updatedAddress;
        }
      }
      notifyListeners();
    }

    return success;
  }

  Future<bool> addAddress(Address addAddress) async {
    final success = await ApiService.addAddress(addAddress);
    if (success) {
      _addresses.add(addAddress);
      await fetchAddressList(addAddress.userId ?? 0);
      notifyListeners();
    }
    return success;
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final userId = _user?.userId;
    if (userId == null) return 'Không tìm thấy người dùng!';

    // Kiểm tra xác nhận mật khẩu mới trước khi gửi API
    if (newPassword != confirmPassword) {
      return 'Mật khẩu xác nhận không khớp!';
    }

    // Gọi hàm đổi mật khẩu từ ApiService
    final result = await ApiService.changePassword(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    // Xử lý trả về theo kết quả của ApiService
    switch (result) {
      case 'success':
        return 'Đổi mật khẩu thành công';
      case 'wrong_old':
        return 'Mật khẩu cũ không đúng';
      case 'wrong_new':
        return 'Không dùng lại mật khẩu cũ';
      default:
        return 'Đổi mật khẩu thất bại';
    }
  }
}
