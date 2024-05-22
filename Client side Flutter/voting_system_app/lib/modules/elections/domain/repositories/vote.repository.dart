import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';

import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';

abstract class VoteRepository {
  Future<Either<Failure, List<Vote>>> getAllVotes();
  Future<Either<Failure, List<Vote>>> getProgrammeVotes(String programmeId);
  Future<Either<Failure, Vote>> saveVoteProgramme(Vote vote);
}
