import 'dart:convert';

import 'package:http/http.dart';

import '../../../../constants/api_constants.dart';
import 'auth_datasource.dart';

class ExpressAuthDatasource implements AuthDatasource {
  @override
  Future<Map<String, dynamic>> createUser({
    required String email,
    required String password,
  }) async {
    try {
      final payload = {
        "email": email,
        "password": password,
      };

      final request = await post(
        Uri.parse("$baseUrl/auth/create-user"),
        headers: {'content-type': 'application/json'},
        body: json.encode(payload),
      );

      final response = json.decode(request.body) as Map<String, dynamic>;
      if (request.statusCode != 201) {
        throw Exception(response);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final request = await post(Uri.parse("$baseUrl/auth/login"),
          headers: {'content-type': 'application/json'},
          body: json.encode({
            "email": email,
            "password": password,
          }));

      final response = json.decode(request.body) as Map<String, dynamic>;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout({
    required int userId,
    required String token,
  }) async {
    try {
      final request = await post(
        Uri.parse("$baseUrl/auth/logout"),
        headers: {
          'Authorization': "Bearer $token",
          'content-type': 'application/json',
        },
        body: json.encode({"id": userId}),
      );
      if (request.statusCode != 200) throw Exception(request.body);
    } catch (e) {
      rethrow;
    }
  }
}
