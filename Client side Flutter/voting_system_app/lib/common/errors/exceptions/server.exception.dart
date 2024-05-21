class ServerException implements Exception {
  final String errorMessage;

  ServerException({required this.errorMessage});
}
