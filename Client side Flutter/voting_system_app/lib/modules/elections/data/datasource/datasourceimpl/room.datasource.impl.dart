// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/datasourceimpl/user.datasource.impl.dart';
import 'package:voting_system_app/modules/elections/data/datasource/room.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';

class RoomDatasourceImpl extends RoomDataSource {
  Future<List<RoomModel>> getAllRooms() async {
    try {
      final resp =
          await UserDataSourceImpl.dio.get("${AppConstants.apiUrl}rooms");
      if (resp.statusCode == 200) {
        List<RoomModel> rooms = [];
        resp.data.map((element) {
          rooms.add(RoomModel.fromJSON(element));
        });
        return rooms;
      } else if (resp.statusCode == 404) {
        throw ServerException(errorMessage: "No Rooms available");
      } else {
        throw Exception(resp.data);
      }
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<bool> addRoom(RoomModel roomModel) async {
    try {
      final resp = await Dio()
          .post("${AppConstants.apiUrl}rooms", data: roomModel.toJSON());
      if (resp.statusCode == 200) {
        return true;
      } else {
        throw ServerException(errorMessage: resp.data);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    return false;
  }
}
