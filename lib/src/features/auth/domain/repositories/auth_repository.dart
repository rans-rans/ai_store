import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> createAccount({
    required String email,
    required String password,
  });
  Future<AuthUser?> loginUser({
    required String email,
    required String password,
  });

  Future<void> logout({
    required int userId,
    required String token,
  });
}
