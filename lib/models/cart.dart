
class CartItem {
  final int productId;
  final String imageUrl;
  final String name;
  final int price;
  final String model;
  int quantity;

  CartItem({
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.model,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['Product_id'] as int,
      imageUrl: json['Image_url'] as String,
      name: json['Name'] as String,
      price: json['Sell_price'] as int,
      model: json['Watch_model'] as String,
      quantity: json['Quantity'] as int,
    );
  }
}
