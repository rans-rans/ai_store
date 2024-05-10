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
      }
    };
  }

  static String getUserName(String? username, String email) {
    final emailName = email.split('@')[0];
    return username ?? emailName;
  }

  factory ExpressAuthUser.fromServer(Map<String, dynamic> data) {
    final userData = data['user'];
    return ExpressAuthUser(
      username: getUserName(data['username'], data['email']),
      userId: userData['id'],
      email: userData['email'],
      authToken: data['token'],
      password: userData['password'],
      phone: userData['phone'],
    );
  }
}
