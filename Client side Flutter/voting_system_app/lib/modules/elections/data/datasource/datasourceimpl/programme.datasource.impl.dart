import 'package:voting_system_app/modules/elections/data/datasource/programme.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/programme.model.dart';

class ProgrammeDataSourceImpl implements ProgrammeDataSource {
  @override
  Future<ProgrammeModel> createProgramme(ProgrammeModel programme) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProgrammeModel>> getRoomProgrammes(String roomId) {
    throw UnimplementedError();
  }
}
