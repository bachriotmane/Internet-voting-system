import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';

abstract class VoteRepository {
  Future<Either<Failure, List<VoteModel>>> getAllVotes();
  Future<Either<Failure, List<VoteModel>>> getProgrammeVotes(
      String programmeId);
  Future<Either<Failure, VoteModel>> saveVoteProgramme(VoteModel vote);
}
