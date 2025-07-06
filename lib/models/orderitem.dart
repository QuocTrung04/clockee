class OrderItem{
  final int productId;
  final int orderId;
  final int quantity;
  final int totalPrice;

  OrderItem({
  required this.productId,
  required this.orderId,
  required this.quantity,
  required this.totalPrice,
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
    );
  }
}

