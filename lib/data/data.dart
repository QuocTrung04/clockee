import 'package:clockee/models/address.dart';
import 'package:clockee/models/user.dart';
import 'package:clockee/models/cart.dart';
import 'package:flutter/material.dart';

int? userId;
User userData = User.empty();
// List<CartItem> cartItems = [];

class AppData extends ChangeNotifier {
  User? _user;
  List<CartItem> _cartItems = [];

  User? get user => _user;
  List<CartItem> get cartItems => _cartItems;

  void setUser(User user) {
    _user = user;
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
}

final List<Address> address = [
  Address(
    name: 'Hoàng Tiến',
    phone: '0392469847',
    province: 'TP. Hồ Chí Minh',
    district: 'Quận Gò Vấp',
    wards: 'Phường 10',
    street: '417/69/27, Quang Trung',
  ),
  Address(
    name: 'Quốc Trung',
    phone: '0392469847',
    province: 'TP. Hồ Chí Minh',
    district: 'Quận Gò Vấp',
    wards: 'Phường 10',
    street: '417/69/27, Quang Trung',
  ),
];
