import 'package:devblogs/core/error/exceptions.dart';
import 'package:devblogs/core/error/failures.dart';
import 'package:devblogs/core/network/network_info.dart';
import 'package:devblogs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:devblogs/features/auth/domain/entities/user.dart';
import 'package:devblogs/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<User> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }
    try {
      final model = await remoteDataSource.login(email, password);
      return model.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
