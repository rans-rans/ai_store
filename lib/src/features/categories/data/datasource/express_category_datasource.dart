import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../constants/api_constants.dart';
import 'category_datasource.dart';

class ExpressCategoryDatasource implements CategoryDatasource {
  @override
  Future<List<Map<String, dynamic>>> fetchAllBrands(String token) async {
    try {
      final request =
          await http.get(Uri.parse('$baseUrl/shop/fetch-brands'), headers: {
        'Authorization': 'Bearer $token',
      });
      final data = json.decode(request.body) as List<dynamic>;
      final brands = data.map((e) => e as Map<String, dynamic>).toList();
      return brands;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllCategories(String token) async {
    try {
      final request = await http.get(Uri.parse('$baseUrl/shop/fetch-categories'),
          headers: {'Authorization': 'Bearer $token'});
      final data = json.decode(request.body) as List<dynamic>;
      final brands = data.map((e) => e as Map<String, dynamic>).toList();
      return brands;
    } catch (e) {
      rethrow;
    }
  }
}
