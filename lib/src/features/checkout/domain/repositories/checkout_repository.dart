import '../../../orders/domain/entities/order.dart';
import '../entities/metadata.dart';

abstract class CheckoutRepository {
  Future<Map<String, dynamic>> initializePayment({
    required Metadata metadata,
    required Order cart,
  });
  Future<bool> verifyTransaction({
    required String key,
    required String ref,
  });
}
