import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/models/programme.model.dart';

abstract class ProgrammeRepository {
  Future<Either<Failure, ProgrammeModel>> createProgramme(
      ProgrammeModel programme);
  Future<Either<Failure, List<ProgrammeModel>>> getRoomProgrammes(
      String roomId);
}
