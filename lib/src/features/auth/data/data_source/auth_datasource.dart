abstract class AuthDatasource {
  Future<Map<String, dynamic>> createUser({
    required String email,
    required String password,
  });
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  });

  Future<void> logout({
    required int userId,
    required String token,
  });
}
