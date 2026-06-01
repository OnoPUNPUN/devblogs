import 'package:devblogs/core/auth/auth_session.dart';
import 'package:devblogs/core/network/api_client.dart';
import 'package:devblogs/core/network/dio_provider.dart';
import 'package:devblogs/core/network/network_info.dart';
import 'package:devblogs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:devblogs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:devblogs/features/auth/domain/repositories/auth_repository.dart';
import 'package:devblogs/features/auth/domain/usecases/login_usecase.dart';
import 'package:devblogs/features/auth/domain/usecases/register_usecase.dart';
import 'package:devblogs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:devblogs/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:devblogs/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:devblogs/features/blog/domain/repositories/blog_repository.dart';
import 'package:devblogs/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:devblogs/features/blog/domain/usecases/get_blog_by_id_usecase.dart';
import 'package:devblogs/features/blog/domain/usecases/get_categories_usecase.dart';
import 'package:devblogs/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:devblogs/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DioProvider.createDio());
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton(
    () => AuthSession(preferences: sl(), apiClient: sl()),
  );
  await sl<AuthSession>().restoreSession();

  // Auth Feature
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl(), authSession: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerFactory(() => AuthBloc(registerUseCase: sl(), loginUseCase: sl()));

  // Blog Feature
  sl.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => UploadBlogUsecase(sl()));
  sl.registerLazySingleton(() => GetAllBlogsUsecase(sl()));
  sl.registerLazySingleton(() => GetBlogByIdUsecase(sl()));
  sl.registerFactory(
    () => BlogBloc(
      getCategoriesUsecase: sl(),
      uploadBlogUsecase: sl(),
      getAllBlogsUsecase: sl(),
      getBlogByIdUsecase: sl(),
    ),
  );
}
