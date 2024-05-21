// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/vote.repository.dart';

class VoteRepositoryImpl extends VoteRepository {
  final VoteDataSource voteDataSource;
  VoteRepositoryImpl({
    required this.voteDataSource,
  });

  @override
  Future<Either<Failure, List<VoteModel>>> getProgrammeVotes(
      String programmeId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoteModel>> saveVoteProgramme(VoteModel vote) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<VoteModel>>> getAllVotes() {
    // TODO: implement getAllVotes
    throw UnimplementedError();
  }
}
