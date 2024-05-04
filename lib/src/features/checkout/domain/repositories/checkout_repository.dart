import '../../../orders/domain/entities/order.dart';

abstract class CheckoutRepository {
  Future<Map<String, dynamic>> initializePayment({
    required String email,
    required Order cart,
  });
  Future<bool> verifyTransaction({
    required String key,
    required String ref,
  });
}
