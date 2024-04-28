import 'package:get_it/get_it.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/datasourceimpl/user.datasource.impl.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/user.datasource.dart';
import 'package:voting_system_app/modules/authentication/data/repository/user.repository.imp.dart';
import 'package:voting_system_app/modules/authentication/domain/repository/user.repository.dart';
import 'package:voting_system_app/modules/authentication/domain/usecase/activation.usecase.dart';
import 'package:voting_system_app/modules/authentication/domain/usecase/add.user.usecase.dart';
import 'package:voting_system_app/modules/authentication/domain/usecase/loginuser.useecase.dart';

final serviceLocator = GetIt.instance;
init() async {
  serviceLocator.registerLazySingleton<AddUserUsecase>(
      () => AddUserUsecase(userRepository: serviceLocator<UserRepository>()));

  serviceLocator.registerLazySingleton<ActivationUsecase>(() =>
      ActivationUsecase(userRepository: serviceLocator<UserRepository>()));

  serviceLocator.registerLazySingleton<UserRepository>(() =>
      UserRepositoryImpl(userDataSource: serviceLocator<UserDataSource>()));

  serviceLocator
      .registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());

  serviceLocator.registerLazySingleton<LoginUserUsecase>(
      () => LoginUserUsecase(userRepo: serviceLocator<UserRepository>()));
}
