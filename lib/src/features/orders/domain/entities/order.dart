import '../../../cart/domain/entities/cart.dart';

abstract class Order {
  final String orderId;
  final String userId;
  final String deliveryLocation;
  final DateTime orderDate;
  final Cart cart;

  Order(
      {required this.orderId,
      required this.userId,
      required this.deliveryLocation,
      required this.orderDate,
      required this.cart});

  Map<String, dynamic> toServer();
}
