import '../../../orders/domain/entities/order.dart';
import '../../domain/entities/metadata.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasource/payment_datasource.dart';

class SupabaseCheckoutRepository implements CheckoutRepository {
  final PaymentDatasource paymentDatasource;

  SupabaseCheckoutRepository({required this.paymentDatasource});

  @override
  Future<Map<String, dynamic>> initializePayment(
      {required Metadata metadata, required Order cart}) async {
    try {
      return await paymentDatasource.initializePayment(
        metadata: metadata,
        order: cart,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyTransaction({required String key, required String ref}) async {
    try {
      return await paymentDatasource.verifyTransaction(
        key: key,
        ref: ref,
      );
    } catch (e) {
      rethrow;
    }
  }
}
