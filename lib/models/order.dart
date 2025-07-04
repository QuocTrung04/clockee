class Order {
  final int orderId;
  final int userId;
  final int receiveId;
  final int totalPrice;
  final String orderCode;
  final int paymentMethod;
  final DateTime paymentDate;
  final DateTime createDate;
  final int orderStatus;
  final DateTime responseDate;

  Order({
    required this.orderId,
    required this.userId,
    required this.receiveId,
    required this.totalPrice,
    required this.orderCode,
    required this.paymentMethod,
    required this.paymentDate,
    required this.createDate,
    required this.orderStatus,
    required this.responseDate,
  });

  Map<String, dynamic> toJson() {
    return{
      'Order_id' : orderId,
      'User_id' : userId,
      'Receive_id':receiveId,
      'Total_price': totalPrice,
      'Order_code': orderCode,
      'Payment_method':paymentMethod,
      'Payment_date':paymentDate,
      'Create_date':createDate,
      'Order_status':orderStatus,
      'Response_date':responseDate,
    };
  }
}

class ReturnOrder{
  final String message;
  final int orderId;
  final String orderCode;
  final int totalPrice;

  ReturnOrder({
    required this.message,
    required this.orderId,
    required this.orderCode,
    required this.totalPrice,
  });

  factory ReturnOrder.fromJson(Map<String, dynamic> json) {
    return ReturnOrder(
       message: json['message'] as String,
       orderId: json['order_id'] as int,
      orderCode: json['order_code'] as String,
      totalPrice: json['total_price'] as int
    );
  }
}
