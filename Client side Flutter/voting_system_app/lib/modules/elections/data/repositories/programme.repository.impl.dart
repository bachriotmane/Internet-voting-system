// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/datasource/programme.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/programme.model.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/programme.repository.dart';

class ProgrammeRepositoryImpl extends ProgrammeRepository {
  final ProgrammeDataSource datasource;
  ProgrammeRepositoryImpl({
    required this.datasource,
  });
  @override
  Future<Either<Failure, ProgrammeModel>> createProgramme(
      ProgrammeModel programme) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProgrammeModel>>> getRoomProgrammes(
      String roomId) async {
    try {
      final resp = await datasource.getRoomProgrammes(roomId);
      return right(resp);
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }
}
