import '../../../orders/domain/entities/order.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasource/payment_datasource.dart';

class ExpressCheckoutRepo implements CheckoutRepository {
  final PaymentDatasource paymentDatasource;

  ExpressCheckoutRepo({required this.paymentDatasource});
  @override
  Future<Map<String, dynamic>> initializePayment(
      {required String email, required Order cart}) async {
    try {
      return await paymentDatasource.initializePayment(email: email, order: cart);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyTransaction({required String key, required String ref}) async {
    try {
      return await paymentDatasource.verifyTransaction(key: key, ref: ref);
    } catch (e) {
      rethrow;
    }
  }
}
