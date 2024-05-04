import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../constants/api_constants.dart';
import 'products_datasource.dart';

class ExpressProductsDatasource implements ProductsDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchGeneralProducts(int userId) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/fetch-products'),
        body: {
          //the data should although but an int but it give an error
          //i am converting to string which works but i will investigate later
          'user_id': userId.toString(),
        },
      );
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
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/fetch-brand-products'),
        body: {
          'id': brandID,
          'user_id': userId,
        },
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
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/fetch-category-products'),
      body: {
        'id': categoryId,
        'user_id': userId,
      },
    );
    final data = json.decode(response.body) as List<dynamic>;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  Stream<bool> listenToFavoriteStatus(
      {required int productId, required int userId}) {
    // TODO: implement listenToFavoriteStatus
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> rateProduct(Rating rating) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/rate-product'),
      body: rating.toMap(),
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  @override
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/remove-saved-product'),
      body: {
        'product_id': productId,
        'user_id': userId,
      },
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  @override
  Future<Map<String, dynamic>> saveProduct({
    required int userId,
    required int productId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/shop/remove-saved-product'),
      body: {
        'product_id': productId,
        'user_id': userId,
      },
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  @override
  Future<Map<String, dynamic>> toggleFavorite({
    required int productId,
    required int userId,
  }) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/toggle-favorite'),
        body: {
          'user_id': userId.toString(),
          'product_id': productId.toString(),
        },
      );
      final response = json.decode(request.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
