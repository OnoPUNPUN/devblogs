abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure([super.message = 'No Internet Connection']);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
