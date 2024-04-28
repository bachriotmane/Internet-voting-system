import 'package:voting_system_app/modules/authentication/data/model/activation.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/authentication.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/jwt.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/user.model.dart';

abstract class UserDataSource {
  Future<bool> addUser(UserModel user);
  Future<bool> activateUserAccount(ActivationModel activationModel);
  Future<JwtModel> loginUser(AuthenticationModel auth);
}
