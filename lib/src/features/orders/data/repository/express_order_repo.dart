import 'package:ai_store/src/features/orders/domain/entities/order.dart';

import '../../domain/entities/express_order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasource/order_datasource.dart';

class ExpressOrderRepo extends OrderRepo {
  final OrderDatasource orderDatasource;

  ExpressOrderRepo({required this.orderDatasource});
  @override
  Future<List<Order>> fetchUserOrders({
    required int userId,
    required String token,
  }) async {
    try {
      final orderData = await orderDatasource.fetchUserOrders(
        userId: userId,
        token: token,
      );
      final orders = orderData.map(ExpressOrder.fromServer);
      return orders.toList();
    } catch (e) {
      rethrow;
    }
  }
}
