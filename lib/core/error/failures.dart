abstract class Failure {}

class ServerFailure extends Failure {
  ServerFailure(this.message);

  final String message;
}

class ConnectionFailure extends Failure {
  ConnectionFailure(this.message);

  final String message;
}
class CacheFailure extends Failure {
  CacheFailure(this.message);

  final String message;
}
