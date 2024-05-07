import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/auth_user.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthUser? user;

  AuthBloc({
    required this.authRepository,
  }) : super(AuthUnAvailable()) {
    on<FetchUser>((event, emit) async {
      user = event.user;
    });
    on<CreateAccountEvent>((event, emit) async {
      try {
        final user = await authRepository.createAccount(
          email: event.email,
          password: event.password,
        );
        if (user == null) {
          emit(AuthActionFailed('invalid credentials'));
          return;
        }
        emit(AuthAvailable(authUser: user));
      } catch (e) {
        emit(AuthActionFailed('unknown error.try again'));
      }
    });
    on<LoginEvent>((event, emit) async {
      try {
        final user = await authRepository.loginUser(
          email: event.email,
          password: event.password,
        );
        this.user = user;
        if (user == null) {
          emit(AuthActionFailed('invalid credentials'));
          return;
        }
        emit(AuthAvailable(authUser: user));
      } catch (e) {
        emit(AuthActionFailed('unknown error.try again'));
      }
    });
    on<LogoutEvent>((event, emit) async {
      try {
        await authRepository
            .logout(userId: event.userId, token: event.token)
            .then((value) => emit(AuthUnAvailable()));
      } catch (e) {
        rethrow;
      }
    });
  }
}
