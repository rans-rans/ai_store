import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../constants/api_constants.dart';
import 'cart_datasource.dart';

class ExpressCartDatasource implements CartDatasource {
  @override
  Future<Map<String, dynamic>> addProductToCart(
      {required Map<String, dynamic> cartItem}) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/add-to-cart'),
        body: json.encode(cartItem),
        headers: {
          'content-type': 'application/json',
        },
      );
      final response = json.decode(request.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> changeProductQuantity(
      {required int productId, required int userId, required int quantity}) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/edit-cartitem-quantity'),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
        }),
      );
      final response = json.decode(request.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchUserCart({required int userId}) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/fetch-user-cart'),
        body: {
          'user_id': userId.toString(),
        },
      );
      final response = json.decode(request.body) as List<dynamic>;
      return response.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> listenToCart({
    required int userId,
  }) {
    // try {} catch (e) {}
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
  }) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/remove-from-cart'),
        headers: {
          'content-type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'product_id': productId,
        }),
      );
      final response = json.decode(request.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
