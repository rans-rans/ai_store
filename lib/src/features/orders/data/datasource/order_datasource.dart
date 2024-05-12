import 'dart:convert';

import 'package:http/http.dart';

import '../../../../constants/api_constants.dart';

class OrderDatasource {
  Future<List<dynamic>> fetchUserOrders({
    required int userId,
    required String token,
  }) async {
    try {
      final request = await post(
        Uri.parse('$baseUrl/shop/fetch-user-orders'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: json.encode({'id': userId}),
      );
      final data = json.decode(request.body) as List<dynamic>;
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
