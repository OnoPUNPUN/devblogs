import 'package:devblogs/core/network/api_client.dart';
import 'package:devblogs/features/auth/data/models/auth_response_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthResponseModel> register({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String _registerEndpoint = '/auth/register';

  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<AuthResponseModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      _registerEndpoint,
      data: {'username': username, 'email': email, 'password': password},
    );

    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}
