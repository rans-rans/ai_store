part of 'auth_bloc.dart';

sealed class AuthState {}

// final class AuthEventLoading extends AuthState {}

final class AuthActionFailed extends AuthState {
  final String message;

  AuthActionFailed(this.message);
}

final class AuthAvailable extends AuthState {
  final AuthUser authUser;

  AuthAvailable({required this.authUser});
}

final class AuthUnAvailable extends AuthState {}
