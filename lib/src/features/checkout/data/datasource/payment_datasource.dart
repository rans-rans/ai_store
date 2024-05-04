import '../../../orders/domain/entities/order.dart';

abstract class PaymentDatasource {
  Future<Map<String, dynamic>> initializePayment({
    required Order order,
    required String email,
  });
  Future<bool> verifyTransaction({
    required String key,
    required String ref,
  });
}
