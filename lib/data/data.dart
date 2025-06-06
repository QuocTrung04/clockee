import 'package:clockee/models/address.dart';
import 'package:clockee/models/sanpham.dart';
import 'package:clockee/models/cart.dart';

final List<SanPham> sanpham = [
  SanPham(
    imageUrl:
        'https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_3840/v1/catalogue/2025/upright-c/m126618ln-0002',
    tenSanPham: 'Đồng Hồ Nam ',
    maSanPham: 'RE-AT0018S00B',
    moTa: '39.3mm | Đồng hồ cơ (Mechanical) ',
    donGia: 28800000,
    gioiTinh: "nam",
    yeuThich: true,
  ),
  SanPham(
    imageUrl:
        'https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_3840/v1/catalogue/2025/upright-c/m126618ln-0002',
    tenSanPham: 'Đồng Hồ Nam ORIENT STAR PHIÊN BẢN GIỚI HẠN ',
    maSanPham: 'RE-AT0018S00B',
    moTa: '39.3mm | Đồng hồ cơ (Mechanical) ',
    donGia: 28800000,
    gioiTinh: "nu",
    yeuThich: true,
  ),

  SanPham(
    imageUrl:
        'https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_3840/v1/catalogue/2025/upright-c/m126618ln-0002',
    tenSanPham: 'Đồng Hồ Nam ORIENT STAR PHIÊN BẢN GIỚI HẠN ',
    maSanPham: 'RE-AT0018S00B',
    moTa: '39.3mm | Đồng hồ cơ (Mechanical) ',
    donGia: 28800000,
    gioiTinh: "nu",
    yeuThich: true,
  ),
];

final List<CartItem> cartItems = [
  CartItem(
    imageUrl:
        'https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_3840/v1/catalogue/2025/upright-c/m126618ln-0002',
    tenSanPham: 'Đồng Hồ Nam ORIENT STAR PHIÊN BẢN GIỚI HẠN',
    maSanPham: 'RE-AT0018S00B',
    price: 28800000,
    soLuong: 1,
  ),
  CartItem(
    imageUrl:
        'https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_3840/v1/catalogue/2025/upright-c/m126618ln-0002',
    tenSanPham: 'Đồng Hồ Nam ORIENT STAR PHIÊN BẢN GIỚI HẠN',
    maSanPham: 'RE-AT0018S00B',
    price: 28800000,
    soLuong: 1,
  ),
  CartItem(
    imageUrl:
        'https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_3840/v1/catalogue/2025/upright-c/m126618ln-0002',
    tenSanPham: 'Đồng Hồ Nam ORIENT STAR PHIÊN BẢN GIỚI HẠN',
    maSanPham: 'RE-AT0018S00B',
    price: 28800000,
    soLuong: 1,
  ),
];

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
