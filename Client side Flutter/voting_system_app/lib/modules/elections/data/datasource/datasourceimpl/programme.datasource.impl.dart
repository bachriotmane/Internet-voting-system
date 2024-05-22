import 'package:dio/dio.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/elections/data/datasource/programme.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/programme.model.dart';

class ProgrammeDataSourceImpl implements ProgrammeDataSource {
  final Dio _dio = serviceLocator<Dio>();
  @override
  Future<ProgrammeModel> createProgramme(ProgrammeModel programme) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProgrammeModel>> getRoomProgrammes(String roomId) async {
    print(roomId);
    final resp = await _dio.get("${AppConstants.apiUrl}programmes/${roomId}");
    print("Hi ");
    if (resp.statusCode == 200) {
      return List<ProgrammeModel>.from((resp.data as List).map(
        (e) => ProgrammeModel.fromJson(e),
      ));
    } else {
      throw ServerException(errorMessage: resp.data);
    }
  }
}
