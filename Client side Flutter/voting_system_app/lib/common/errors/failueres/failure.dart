class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class TokenExpiredFailure extends Failure {
  TokenExpiredFailure({required super.message});
}
