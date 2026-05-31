class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class ConnectionException implements Exception {
  final String message;
  const ConnectionException([this.message = 'No Internet Connection']);
}
