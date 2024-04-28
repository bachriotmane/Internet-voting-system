import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';
import 'package:voting_system_app/common/errors/exceptions/token.expired.exception.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/user.datasource.dart';
import 'package:voting_system_app/modules/authentication/data/model/activation.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/authentication.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/jwt.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/user.model.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/activation.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/authentication.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/jwt.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/authentication/domain/repository/user.repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(User user) async {
    try {
      final result = await userDataSource.addUser(
        UserModel(
          id: user.id,
          email: user.email,
          location: user.location,
          memeberSince: user.memeberSince,
          password: user.password,
          username: user.username,
        ),
      );
      return right(result);
    } on ServerException catch (err) {
      return left(ServerFailure(message: err.errorMessage));
    } catch (exp) {
      return left(Failure(message: exp.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> activateUserAccount(
      Activation activation) async {
    try {
      bool resp = await userDataSource
          .activateUserAccount(ActivationModel(code: activation.code));
      return right(resp);
    } on DioException catch (err) {
      return left(ServerFailure(message: err.response!.data));
    }
  }

  @override
  Future<Either<Failure, Jwt>> loginUser(Authentication authentication) async {
    try {
      JwtModel jwtM = await userDataSource.loginUser(AuthenticationModel(
          grantType: authentication.grantType,
          username: authentication.username,
          refreshToken: authentication.refreshToken,
          password: authentication.password,
          withRefreshToen: authentication.withRefreshToen));
      return right(
          Jwt(accessToken: jwtM.accessToken, refreshToken: jwtM.refreshToken));
    } on TokenExpiredException catch (err) {
      return left(TokenExpiredFailure(message: err.toString()));
    } on ServerException catch (err) {
      return left(ServerFailure(message: err.toString()));
    } catch (err) {
      return left(ServerFailure(message: ""));
    }
  }
}
