import 'package:voting_system_app/modules/authentication/domain/entities/jwt.dart';

class JwtModel extends Jwt {
  JwtModel({
    super.accessToken,
    super.refreshToken,
  });
  factory JwtModel.fromJson(Map<String, dynamic> json) => JwtModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
}
