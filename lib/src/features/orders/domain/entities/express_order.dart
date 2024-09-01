import '../../../cart/domain/entities/express_cart.dart';
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
    required super.totalCost,
  });

  factory ExpressOrder.fromServer(dynamic data) {
    try {
      final productsData =
          (data['items'] as List<dynamic>).map((e) => e as Map<String, dynamic>);
      final cartItems = productsData.map((item) {
        return ExpressCartItem(
          quantity: item['quantity'],
          productId: item['product_id'],
          userId: item['user_id'],
          discount: (item['discount'] / 1.0),
          productName: item['name'],
          productPrice: (item['price'] / 1.0),
          imageUrl: item['image_url'],
        );
      }).toList();
      return ExpressOrder(
        cart: ExpressCart(products: cartItems),
        customerName: data['customer_name'],
        deliveryLocation: data['location'],
        orderDate: DateTime.parse(data['date']),
        totalCost: double.parse(data['total_cost']),
        orderId: data['order_id'],
        userId: data['user_id'],
        status: data['status'] == 0 ? OrderStatus.pending : OrderStatus.delivered,
      );
    } catch (e) {
      rethrow;
    }
  }
}
