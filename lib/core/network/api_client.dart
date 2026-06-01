import 'package:dio/dio.dart';
import 'package:devblogs/core/utils/app_logger.dart';

class ApiClient {
  final Dio dio;
  String? _token;

  ApiClient(this.dio);

  void updateToken(String? token) {
    _token = token;
  }

  Options _optionsWithAuth(Options? options) {
    final newOptions = options ?? Options();
    if (_token != null) {
      newOptions.headers ??= {};
      newOptions.headers!['Authorization'] = 'Bearer $_token';
    }
    return newOptions;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    AppLogger.i('GET Request: $path');
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: _optionsWithAuth(options),
      );
      AppLogger.i('GET Response: ${response.statusCode} - ${response.data}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('GET Error: $path', e.message);
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    AppLogger.i('POST Request: $path | Data: $data');
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithAuth(options),
      );
      AppLogger.i('POST Response: ${response.statusCode} - ${response.data}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('POST Error: $path', e.message);
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    AppLogger.i('PUT Request: $path | Data: $data');
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithAuth(options),
      );
      AppLogger.i('PUT Response: ${response.statusCode} - ${response.data}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('PUT Error: $path', e.message);
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    AppLogger.i('DELETE Request: $path');
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _optionsWithAuth(options),
      );
      AppLogger.i('DELETE Response: ${response.statusCode} - ${response.data}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('DELETE Error: $path', e.message);
      rethrow;
    }
  }
}

