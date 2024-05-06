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
  Future<AuthUser> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final request =
          await authDatasource.createUser(email: email, password: password);
      final user = ExpressAuthUser.fromServer(request);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUser> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final request = await authDatasource.loginUser(
        email: email,
        password: password,
      );
      final user = ExpressAuthUser.fromServer(request);
      final prefs = await SharedPreferences.getInstance();

      //although setString is a future, there isn't a need to await it
      prefs.setString('user', json.encode(user.toMap()));

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUser?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData == null) return null;
    final user = json.decode(userData) as Map<String, dynamic>;
    return ExpressAuthUser.fromServer(user);
  }

  @override
  Future<void> logout({required int userId, required String token}) async {
    return await authDatasource.logout(
      userId: userId,
      token: token,
    );
  }
}
