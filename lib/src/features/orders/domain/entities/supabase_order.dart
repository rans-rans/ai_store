import 'dart:convert';

import 'order.dart';

class SupabaseOrder extends Order {
  SupabaseOrder(
      {required super.orderId,
      required super.userId,
      required super.deliveryLocation,
      required super.orderDate,
      required super.cart});

  @override
  Map<String, dynamic> toServer() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'order_date': orderDate.toIso8601String(),
      'delivery_location': deliveryLocation,
      'items': json.encode(cart.products.map((item) => item.toServer())),
    };
  }
}
