import 'package:devblogs/features/auth/domain/entities/auth_response.dart';
import 'package:devblogs/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<AuthResponse> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
