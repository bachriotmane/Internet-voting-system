import 'package:voting_system_app/modules/authentication/domain/entities/activation.dart';

class ActivationModel extends Activation {
  ActivationModel({required super.code});

  factory ActivationModel.fronJson(Map<String, dynamic> json) =>
      ActivationModel(
        code: json["code"],
      );
  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
