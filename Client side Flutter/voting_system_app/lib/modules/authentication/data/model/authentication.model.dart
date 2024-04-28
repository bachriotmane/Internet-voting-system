import 'package:voting_system_app/modules/authentication/domain/entities/authentication.dart';

class AuthenticationModel extends Authentication {
  AuthenticationModel({
    required super.grantType,
    required super.username,
    required super.password,
    super.refreshToken,
    required super.withRefreshToen,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        username: json['username'],
        password: json['password'],
        withRefreshToen: json['withRefreshToken'],
        grantType: json['grantType'],
        refreshToken: json['refreshToken'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['withRefreshToken'] = withRefreshToen;
    data['grantType'] = grantType;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
