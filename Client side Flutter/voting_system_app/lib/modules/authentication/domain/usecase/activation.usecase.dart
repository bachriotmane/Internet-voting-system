import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/activation.dart';
import 'package:voting_system_app/modules/authentication/domain/repository/user.repository.dart';

class ActivationUsecase {
  final UserRepository userRepository;

  ActivationUsecase({required this.userRepository});

  Future<Either<Failure, bool>> execute(Activation activation) async {
    return await userRepository.activateUserAccount(activation);
  }
}
