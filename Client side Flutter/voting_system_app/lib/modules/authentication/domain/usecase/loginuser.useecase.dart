import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/authentication.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/jwt.dart';
import 'package:voting_system_app/modules/authentication/domain/repository/user.repository.dart';

class LoginUserUsecase {
  final UserRepository userRepo;

  LoginUserUsecase({required this.userRepo});

  Future<Either<Failure, Jwt>> execute(Authentication auth) async {
    return await userRepo.loginUser(auth);
  }
}
