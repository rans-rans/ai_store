import '../entities/order.dart';

abstract class OrderRepo {
  Future<List<Order>> fetchUserOrders({
    required int userId,
    required String token,
  });
}
