// ignore_for_file: avoid_print

import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/datasourceimpl/user.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';

class VoteDataSourceImpl extends VoteDataSource {
  // final Dio _dio = serviceLocator<Dio>();
  @override
  Future<List<VoteModel>> getAllVotes() async {
    try {
      final resp =
          await UserDataSourceImpl.dio.get("${AppConstants.apiUrl}rooms");
      print("Hi");
      print(resp.data);
      return [];
    } catch (err) {
      print(err.toString());
      return [];
    }
  }
}
