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


