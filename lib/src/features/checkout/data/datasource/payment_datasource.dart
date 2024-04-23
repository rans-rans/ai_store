import '../../../orders/domain/entities/order.dart';
import '../../domain/entities/metadata.dart';

abstract class PaymentDatasource {
  Future<Map<String, dynamic>> initializePayment({
    required Metadata metadata,
    required Order order,
  });
  Future<bool> verifyTransaction({
    required String key,
    required String ref,
  });
}
