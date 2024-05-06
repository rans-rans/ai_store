part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class CreateAccountEvent extends AuthEvent {
  final String email;
  final String password;

  CreateAccountEvent({required this.email, required this.password});
}

final class LogoutEvent extends AuthEvent {
  final int userId;
  final String token;

  LogoutEvent({required this.userId, required this.token});
}

final class FetchUser extends AuthEvent {}
