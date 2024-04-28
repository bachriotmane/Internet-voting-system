import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/activation.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/authentication.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/jwt.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> registerUser(User user);
  Future<Either<Failure, bool>> activateUserAccount(Activation activation);
  Future<Either<Failure, Jwt>> loginUser(Authentication authentication);
}
