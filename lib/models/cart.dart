class CartItem {
  final String imageUrl;
  final String tenSanPham;
  final String maSanPham;
  final int price;
  int soLuong;

  CartItem({
    required this.imageUrl,
    required this.tenSanPham,
    required this.maSanPham,
    required this.price,
    this.soLuong = 1,
  });
}
