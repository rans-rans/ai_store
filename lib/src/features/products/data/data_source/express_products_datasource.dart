import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../constants/api_constants.dart';
import 'products_datasource.dart';

class ExpressProductsDatasource implements ProductsDataSource {
  @override
  Future<List<dynamic>> fetchGeneralProducts(String token) async {
    try {
      final request = await http.get(Uri.parse('$baseUrl/shop/fetch-products'),
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      final data = json.decode(request.body) as List<dynamic>;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchProductDetails({
    required int productId,
    required int userId,
    required String authToken,
  }) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/fetch-product-details'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode({
          'product_id': productId,
          'id': userId,
        }),
      );
      final description = json.decode(request.body) as Map<String, dynamic>;
      return description;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchProductsByBrand({
    required int brandID,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/fetch-brand-products'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        },
        body: json.encode({'brand_id': brandID}),
      );
      final data = json.decode(response.body) as List<dynamic>;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchProductsBycategory({
    required int categoryId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shop/fetch-category-products'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        },
        body: json.encode({'category_id': categoryId}),
      );
      final data = json.decode(response.body) as List<dynamic>;
      return data;
    } catch (e) {
      print("error  in  here  $e");
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchProductRatings({
    required String token,
    required int productId,
  }) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/fetch-product-ratings'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'product_id': productId}),
      );

      final ratingsData = json.decode(request.body) as List<dynamic>;
      return ratingsData;
    } catch (e) {
      rethrow;
    }
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
  Future<dynamic> removeProductRating({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      final request = await http.post(
        Uri.parse('$baseUrl/shop/remove-product-rating'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'id': userId,
          'product_id': productId,
        }),
      );
      return request;
    } catch (e) {
      rethrow;
    }
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
