import 'package:devblogs/core/auth/auth_session.dart';
import 'package:devblogs/core/network/api_client.dart';
import 'package:devblogs/features/auth/data/models/auth_response_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthResponseModel> register({
    required String username,
    required String email,
    required String password,
  });

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String _registerEndpoint = '/auth/register';
  static const String _loginEndpoint = '/auth/login';

  final ApiClient apiClient;
  final AuthSession authSession;

  AuthRemoteDataSourceImpl({
    required this.apiClient,
    required this.authSession,
  });

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

    final model = AuthResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
    await authSession.saveToken(model.token);
    return model;
  }

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      _loginEndpoint,
      data: {'email': email, 'password': password},
    );

    final model = AuthResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
    await authSession.saveToken(model.token);
    return model;
  }
}
