import 'package:voting_system_app/modules/elections/data/models/programme.model.dart';

abstract class ProgrammeDataSource {
  Future<ProgrammeModel> createProgramme(ProgrammeModel programme);
  Future<List<ProgrammeModel>> getRoomProgrammes(String roomId);
}
