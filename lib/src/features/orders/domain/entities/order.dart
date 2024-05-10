import 'dart:convert';

import '../../../cart/domain/entities/cart.dart';

class Order {
  final int orderId;
  final int userId;
  final String deliveryLocation;
  final DateTime orderDate;
  final Cart cart;
  final String customerName;
  final OrderStatus status;

  Order({
    required this.cart,
    required this.customerName,
    required this.deliveryLocation,
    required this.orderDate,
    this.orderId = 0,
    this.status = OrderStatus.pending,
    required this.userId,
  });

  Map<String, dynamic> toMap(double cost) {
    return {
      'order_id': orderId,
      'user_id': userId,
      'total_cost': cost,
      'customer_name': customerName,
      'order_date': orderDate.toIso8601String(),
      'delivery_location': deliveryLocation,
      'cart': json.encode(cart.products.map((item) => item.toServer()).toList()),
    };
  }
}

enum OrderStatus { pending, delivered }
//0----->pending
//1----->delivered
