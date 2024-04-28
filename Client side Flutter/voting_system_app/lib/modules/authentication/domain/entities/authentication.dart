class Authentication {
  final String username;
  final String password;
  final bool withRefreshToen;
  final String grantType;
  String? refreshToken;

  Authentication({
    required this.username,
    required this.password,
    required this.withRefreshToen,
    required this.grantType,
    this.refreshToken,
  });

  @override
  String toString() {
    return 'Authentication { username: $username, password: $password, withRefreshToken: $withRefreshToen, grantType: $grantType, refreshToken: $refreshToken }';
  }
}
