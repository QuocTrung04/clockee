class OrderItem{
  final int productId;
  final int orderId;
  final int quantity;
  final int totalPrice;
  final String productName;
  final int sellPrice;
  final String imageUrl;
  final int actualPrice;
  final String watch_model;

  OrderItem({
  required this.productId,
  required this.orderId,
  required this.quantity,
  required this.totalPrice,
  required this.imageUrl,
  required this.productName,
  required this.sellPrice,
  required this.actualPrice,
  required this.watch_model,
  });

  Map<String,dynamic> toJson(){
    return{
      'Product_id':productId,
      'Order_id':orderId,
      'Quantity':quantity,
      'Total_price':totalPrice
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['Product_id'],
      orderId: json['Order_id'],
      quantity: json['Quantity'],
      totalPrice: json['Total_price'],
      productName: json['Name'],
      sellPrice: json['Sell_price'],
      imageUrl: json['Image_url'],
      actualPrice: json['Actual_price'],
      watch_model: json['Watch_model'],
    );
  }
}

