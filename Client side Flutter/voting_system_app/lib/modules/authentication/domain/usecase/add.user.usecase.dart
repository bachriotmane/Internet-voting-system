import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/authentication/domain/repository/user.repository.dart';

class AddUserUsecase {
  final UserRepository userRepository;

  AddUserUsecase({required this.userRepository});

  Future<Either<Failure, bool>> execute(User user) async {
    return await userRepository.registerUser(user);
  }
}
