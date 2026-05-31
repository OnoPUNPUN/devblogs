import 'package:devblogs/core/error/exceptions.dart';
import 'package:devblogs/core/network/api_client.dart';
import 'package:devblogs/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiClient.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.data == null) {
        throw const ServerException('Null response from server');
      }
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
