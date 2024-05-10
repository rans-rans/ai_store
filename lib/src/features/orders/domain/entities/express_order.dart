import 'order.dart';

class ExpressOrder extends Order {
  ExpressOrder({
    required super.cart,
    required super.customerName,
    required super.deliveryLocation,
    required super.orderDate,
    super.orderId,
    super.status,
    required super.userId,
  });

  factory ExpressOrder.fromServer(dynamic data) {
    return ExpressOrder(
      cart: data['cart'],
      customerName: data['customer_nme'],
      deliveryLocation: data['location'],
      orderDate: data['date'],
      orderId: data['order_id'],
      userId: data['user_id'],
      status: data['status'] == 0 ? OrderStatus.pending : OrderStatus.delivered,
    );
  }
}
