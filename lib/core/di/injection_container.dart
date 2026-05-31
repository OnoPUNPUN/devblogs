import 'package:devblogs/core/network/api_client.dart';
import 'package:devblogs/core/network/dio_provider.dart';
import 'package:devblogs/core/network/network_info.dart';
import 'package:devblogs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:devblogs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:devblogs/features/auth/domain/repositories/auth_repository.dart';
import 'package:devblogs/features/auth/domain/usecases/login_usecase.dart';
import 'package:devblogs/features/auth/domain/usecases/register_usecase.dart';
import 'package:devblogs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DioProvider.createDio());
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton(() => RegisterUsecase(sl()));

  sl.registerFactory(() => AuthBloc(registerUseCase: sl(), loginUseCase: sl()));

  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
}
