import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/auth_user.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthUnAvailable()) {
    on<FetchUser>((event, emit) async {
      try {
        final user = await authRepository.getUserData();
        if (user == null) {
          return emit(AuthUnAvailable());
        }
        return emit(AuthAvailable(authUser: user));
      } catch (e) {
        rethrow;
      }
    });
    on<CreateAccountEvent>((event, emit) async {
      try {
        final user = await authRepository.createAccount(
          email: event.email,
          password: event.password,
        );
        emit(AuthAvailable(authUser: user));
      } catch (e) {
        emit(AuthActionFailed(e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      try {
        final user = await authRepository.loginUser(
          email: event.email,
          password: event.password,
        );
        emit(AuthAvailable(authUser: user));
      } catch (e) {
        emit(AuthActionFailed(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) {
      try {
        authRepository
            .logout(userId: event.userId, token: event.token)
            .then((value) {
          emit(AuthUnAvailable());
        });
      } catch (e) {
        rethrow;
      }
    });
  }
}
