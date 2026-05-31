import 'package:devblogs/features/auth/domain/entities/auth_response.dart';

abstract interface class AuthRepository {
  Future<AuthResponse> register({
    required String username,
    required String email,
    required String password,
  });

  Future<AuthResponse> login({required String email, required String password});
}
