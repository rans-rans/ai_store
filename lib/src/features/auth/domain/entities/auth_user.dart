abstract class AuthUser {
  final String authToken;
  final String email;
  final String password;
  final String? phone;
  final String username;
  final int userId;

  AuthUser({
    required this.authToken,
    required this.userId,
    required this.email,
    required this.password,
    required this.phone,
    required this.username,
  });

  Map<String, dynamic> toMap();
}
