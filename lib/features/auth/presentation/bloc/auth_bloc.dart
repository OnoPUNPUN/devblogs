import 'package:devblogs/core/error/failures.dart';
import 'package:devblogs/features/auth/domain/entities/auth_response.dart';
import 'package:devblogs/features/auth/domain/usecases/login_usecase.dart';
import 'package:devblogs/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase _registerUseCase;
  final LoginUsecase _loginUseCase;

  AuthBloc({
    required RegisterUsecase registerUseCase,
    required LoginUsecase loginUseCase,
  }) : _registerUseCase = registerUseCase,
       _loginUseCase = loginUseCase,
       super(AuthInitial()) {
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLoginRequested>(_onLoginRequested);
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final authResponse = await _registerUseCase(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(authResponse));
    } on Failure catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final authResponse = await _loginUseCase(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(authResponse));
    } on Failure catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
