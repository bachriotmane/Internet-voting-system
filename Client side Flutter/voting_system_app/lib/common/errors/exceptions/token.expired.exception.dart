class TokenExpiredException implements Exception {
  final String message;

  TokenExpiredException({required this.message});
}
