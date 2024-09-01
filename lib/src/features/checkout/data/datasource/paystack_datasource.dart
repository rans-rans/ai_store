import 'dart:convert';

import 'package:flutter_paystack_max/flutter_paystack_max.dart';
import 'package:http/http.dart';

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

      final url = Uri.parse('https://api.paystack.co/transaction/initialize');

      final res = await post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $secrectKey',
          },
          body: json.encode(
            {
              "email": email,
              "amount": (amount * 100).ceilToDouble(),
              "currency": "GHS",
              "metadata": order.toMap(),
              "channel": ["mobile_money"],
              "reference": reference,
            },
          ));

      // final response = await PaymentService.initializeTransaction(request);
      return json.decode(res.body) as Map<String, dynamic>;
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
