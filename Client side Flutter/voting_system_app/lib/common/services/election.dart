import 'package:get_it/get_it.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/elections/data/datasource/datasourceimpl/programme.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/datasourceimpl/room.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/datasourceimpl/vote.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/programme.datasource.dart';
import 'package:voting_system_app/modules/elections/data/datasource/room.datasource.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/data/repositories/programme.repository.impl.dart';
import 'package:voting_system_app/modules/elections/data/repositories/room.repository.impl.dart';
import 'package:voting_system_app/modules/elections/data/repositories/vote.repository.impl.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/programme.repository.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/vote.repository.dart';

final serviceLocatorElection = GetIt.instance;
initElection() {
  serviceLocatorElection
      .registerLazySingleton<VoteDataSource>(() => VoteDataSourceImpl());
  serviceLocatorElection.registerLazySingleton<VoteRepository>(() =>
      VoteRepositoryImpl(
          voteDataSource: serviceLocatorElection<VoteDataSource>()));
  serviceLocatorElection
      .registerLazySingleton<RoomDataSource>(() => RoomDataSourceImpl());

  serviceLocatorElection.registerLazySingleton<RoomRepository>(() =>
      RoomRepositoryImpl(datasource: serviceLocatorElection<RoomDataSource>()));
  serviceLocatorElection.registerLazySingleton<ProgrammeDataSource>(
      () => ProgrammeDataSourceImpl());
  serviceLocatorElection.registerLazySingleton<ProgrammeRepository>(
    () => ProgrammeRepositoryImpl(
      datasource: serviceLocatorElection<ProgrammeDataSource>(),
    ),
  );
}
