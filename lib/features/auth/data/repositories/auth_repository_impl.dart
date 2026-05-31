import 'package:devblogs/core/error/exceptions.dart';
import 'package:devblogs/core/error/failures.dart';
import 'package:devblogs/core/network/network_info.dart';
import 'package:devblogs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:devblogs/features/auth/domain/entities/auth_response.dart';
import 'package:devblogs/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }

    try {
      return await remoteDataSource.login(email: email, password: password);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<AuthResponse> register({
    required String username,
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }

    try {
      return await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }
}
