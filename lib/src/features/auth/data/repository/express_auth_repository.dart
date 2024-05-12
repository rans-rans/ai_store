import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/entities/express_auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/auth_datasource.dart';

class ExpressAuthRepo implements AuthRepository {
  final AuthDatasource authDatasource;

  ExpressAuthRepo({required this.authDatasource});
  @override
  Future<AuthUser?> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final request =
          await authDatasource.createUser(email: email, password: password);
      final user = ExpressAuthUser.fromMap(request);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(user.toMap()));

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUser?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final request = await authDatasource.loginUser(
        email: email,
        password: password,
      );
      if (request['token'] == null) return null;
      final user = ExpressAuthUser.fromMap(request);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(user.toMap()));

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout({required int userId, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    return await authDatasource.logout(
      userId: userId,
      token: token,
    );
  }
}
