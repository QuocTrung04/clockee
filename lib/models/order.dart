import 'package:clockee/models/orderitem.dart';

class Order {
  final int orderId;
  final int userId;
  final int receiveId;
  final int totalPrice;
  final String orderCode;
  final int paymentMethod;
  final DateTime? paymentDate;
  final int paymentStatus;
  final DateTime createDate;
  final int orderStatus;
  final DateTime responseDate;
  final List<OrderItem> items;
  Order({
    required this.orderId,
    required this.userId,
    required this.receiveId,
    required this.totalPrice,
    required this.orderCode,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
    required this.createDate,
    required this.orderStatus,
    required this.responseDate,
    required this.items
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

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['Items'] as List<dynamic>? ?? [];
    List<OrderItem> itemList = itemsJson.map((e) => OrderItem.fromJson(e)).toList();

    return Order(
      orderId: json['Order_id'],
      userId: json['User_id'],
      receiveId: json['Receive_id'],
      totalPrice: json['Total_price'],
      orderCode: json['Order_code'],
      paymentMethod: json['Payment_method'],
      paymentDate: json['Payment_date'],
      paymentStatus: json['Payment_status'],
      createDate: json['Create_date'],
      responseDate: json['Response_date'],
      orderStatus: json['Order_status'],
      items: itemList,
    );
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
