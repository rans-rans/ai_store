import 'dart:convert';

import 'package:flutter_paystack_max/flutter_paystack_max.dart';

import '../../../../constants/api_constants.dart';
import '../../../../utils/helper_functions.dart';
import '../../../orders/domain/entities/order.dart';
import 'payment_datasource.dart';

class PaystackDatasource implements PaymentDatasource {
  @override
  Future<Map<String, dynamic>> initializePayment({
    required Order order,
    required String email,
  }) async {
    try {
      final amount = await HelperFunctions.getCartTotalPrice(order.cart.products);
      final now = DateTime.now();
      final reference =
          '${now.year}${now.month}${now.day}${now.day}${now.hour}${now.minute}${now.second}';

      final request = PaystackTransactionRequest(
        reference: reference,
        secretKey: secrectKey,
        email: email,
        amount: (amount * 100).ceilToDouble(),
        metadata: json.encode(order.toMap()),
        currency: PaystackCurrency.ghs,
        channel: [PaystackPaymentChannel.mobileMoney],
      );

      final response = await PaymentService.initializeTransaction(request);
      return response.toMap();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyTransaction({
    required String key,
    required String ref,
  }) async {
    final response = await PaymentService.verifyTransaction(
      ref,
      paystackSecretKey: key,
    );
    return response.status;
  }
}
