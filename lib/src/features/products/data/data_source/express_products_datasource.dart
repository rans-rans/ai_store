import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../constants/api_constants.dart';
import 'products_datasource.dart';

class ExpressProductsDatasource implements ProductsDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchGeneralProducts(
      int userId, String token) async {
    try {
      final request = await http.post(Uri.parse('$baseUrl/shop/fetch-products'),
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(
            {
              //TODO  the data should although but an int but it give an error
              //i am converting to string which works but i will investigate later
              'id': userId.toString(),
            },
          ));
      final data = json.decode(request.body) as List<dynamic>;
      final productsData = data.map((e) => e as Map<String, dynamic>).toList();
      return productsData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProductsByBrand({
    required int brandID,
    required int userId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/fetch-brand-products'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        },
        body: json.encode({
          'brand_id': brandID,
          'id': userId,
        }),
      );
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProductsBycategory({
    required int categoryId,
    required int userId,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/fetch-category-products'),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json',
      },
      body: json.encode({
        'category_id': categoryId,
        'id': userId,
      }),
    );
    final data = json.decode(response.body) as List<dynamic>;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  Future<Map<String, dynamic>> rateProduct(Rating rating, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/rate-product'),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json',
      },
      body: json.encode(rating.toMap()),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  @override
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/remove-saved-product'),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json',
      },
      body: json.encode({
        'product_id': productId,
        'id': userId,
      }),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  @override
  Future<Map<String, dynamic>> saveProduct({
    required int userId,
    required String token,
    required int productId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/remove-saved-product'),
      headers: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json',
      },
      body: json.encode({
        'product_id': productId,
        'id': userId,
      }),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  @override
  Future<Map<String, dynamic>> toggleFavorite({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/toggle-favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        },
        body: json.encode({
          'id': userId.toString(),
          'product_id': productId.toString(),
        }),
      );
      final response = json.decode(request.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
