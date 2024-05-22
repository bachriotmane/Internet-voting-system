// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/datasourceimpl/user.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';

class VoteDataSourceImpl extends VoteDataSource {
  final Dio _dio = serviceLocator<Dio>();

  @override
  Future<VoteModel> saveVoteProgramme(VoteModel vote) async {
    final resp =
        await _dio.post("${AppConstants.apiUrl}votes/", data: vote.toJSON());
    if (resp.statusCode == 200) {
      print(resp.data.toString());
      return VoteModel.fromJSON(resp.data);
    } else {
      throw ServerException(errorMessage: resp.data);
    }
  }

  @override
  Future<List<VoteModel>> getAllVotes() async {
    try {
      final resp =
          await UserDataSourceImpl.dio.get("${AppConstants.apiUrl}votes/");
      return List<VoteModel>.from((resp.data as List).map(
        (e) => VoteModel.fromJSON(e),
      ));
    } catch (err) {
      throw ServerException(errorMessage: err.toString());
    }
  }

  @override
  Future<List<VoteModel>> getProgrammeVotes(String programmeId) async {
    final resp =
        await _dio.get("${AppConstants.apiUrl}votes/programme/${programmeId}");
    if (resp.statusCode == 200) {
      print("||||||||||" + resp.data.toString());
      return List<VoteModel>.from((resp.data as List).map(
        (e) => VoteModel.fromJSON(e),
      ));
    } else {
      throw ServerException(errorMessage: resp.data);
    }
  }
}
