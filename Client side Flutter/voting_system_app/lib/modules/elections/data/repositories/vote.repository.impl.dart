// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/vote.repository.dart';

class VoteRepositoryImpl extends VoteRepository {
  final VoteDataSource voteDataSource;
  VoteRepositoryImpl({
    required this.voteDataSource,
  });

  @override
  Future<Either<Failure, List<Vote>>> getProgrammeVotes(String programmeId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Vote>> saveVoteProgramme(Vote vote) async {
    try {
      final resp = await voteDataSource.saveVoteProgramme(
        VoteModel(
          id: vote.id,
          date: vote.date,
          voterId: vote.voterId,
          votedProgramme: vote.votedProgramme,
        ),
      );
      return right(resp);
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Vote>>> getAllVotes() {
    throw UnimplementedError();
  }
}
