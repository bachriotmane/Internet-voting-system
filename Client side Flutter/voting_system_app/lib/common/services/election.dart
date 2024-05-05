import 'package:get_it/get_it.dart';
import 'package:voting_system_app/modules/elections/data/datasource/datasourceimpl/vote.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/data/repositories/vote.repository.impl.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/vote.repository.dart';

final serviceLocator = GetIt.instance;
init() {
  serviceLocator
      .registerLazySingleton<VoteDataSource>(() => VoteDataSourceImpl());
  serviceLocator.registerLazySingleton<VoteRepository>(() =>
      VoteRepositoryImpl(voteDataSource: serviceLocator<VoteDataSource>()));
}
