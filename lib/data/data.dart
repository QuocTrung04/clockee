import 'dart:convert';

import 'package:clockee/data/user_prefs.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/models/user.dart';
import 'package:clockee/models/cart.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  User? _user;
  List<CartItem> _cartItems = [];
  List<Address> _addresses = [];

  User? get user => _user;
  List<CartItem> get cartItems => _cartItems;
  List<Address> get addresses => _addresses;

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
    // Gọi API
    final success = await ApiService.editAddress(
      updatedAddress.receiveid!,
      updatedAddress,
    );

    if (success) {
      // Tìm vị trí của address cần update trong _addresses
      final idx = _addresses.indexWhere(
        (a) => a.receiveid == updatedAddress.receiveid,
      );
      if (idx != -1) {
        _addresses[idx] = updatedAddress;
        notifyListeners();
      }
    }
    return success;
  }
}
