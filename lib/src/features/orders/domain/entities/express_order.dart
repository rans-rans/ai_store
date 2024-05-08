import 'dart:convert';

import 'order.dart';

class ExpressOrder extends Order {
  ExpressOrder({
    required super.orderId,
    required super.userId,
    required super.deliveryLocation,
    required super.orderDate,
    required super.cart,
  });

  @override
  Map<String, dynamic> toServer(double cost) {
    //TODO  add dynamic user-name
    return {
      'order_id': orderId,
      'id': userId,
      'total_cost': cost,
      'customer_name': 'Rans',
      'order_date': orderDate.toIso8601String(),
      'delivery_location': deliveryLocation,
      'cart': json.encode(cart.products.map((item) => item.toServer()).toList()),
    };
  }
}
