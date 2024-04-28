import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.password,
    required super.location,
    required super.memeberSince,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        location: json["location"],
        memeberSince: DateTime.parse(json["memeberSince"]),
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "email": email,
        "location": location,
        "memeberSince": memeberSince.toIso8601String(),
      };
}
