import 'auth_user.dart';

class ExpressAuthUser extends AuthUser {
  ExpressAuthUser({
    required super.userId,
    required super.email,
    required super.authToken,
    required super.password,
    required super.username,
    super.phone,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'token': authToken,
      'user': {
        'email': email,
        'phone': phone,
        'password': password,
        'id': userId,
        'username': username ?? email.split('@')[0],
      }
    };
  }

  factory ExpressAuthUser.fromServer(Map<String, dynamic> data) {
    final userData = data['user'];
    final email = userData['email'] as String;
    final username = userData['username'] as String?;
    return ExpressAuthUser(
      username: username ?? email.split('@')[0],
      userId: userData['id'],
      email: email,
      authToken: data['token'],
      password: userData['password'],
      phone: userData['phone'],
    );
  }
}
