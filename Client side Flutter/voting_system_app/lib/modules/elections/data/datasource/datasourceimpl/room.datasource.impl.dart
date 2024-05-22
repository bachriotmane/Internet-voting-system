import 'package:dio/dio.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/authentication/data/model/user.model.dart';
import 'package:voting_system_app/modules/elections/data/datasource/room.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';

class RoomDataSourceImpl implements RoomDataSource {
  final Dio _dio = serviceLocator<Dio>();
  @override
  Future<RoomModel> createRoom(RoomModel room) async {
    final resp =
        await _dio.post("${AppConstants.apiUrl}rooms/", data: room.toJson());
    if (resp.statusCode == 200) {
      return RoomModel.fromJson(resp.data);
    } else {
      throw ServerException(errorMessage: resp.data);
    }
  }

  @override
  Future<List<RoomModel>> getAllRooms() async {
    final resp = await _dio.get("${AppConstants.apiUrl}rooms");
    if (resp.statusCode == 200) {
      return List<RoomModel>.from((resp.data as List).map(
        (e) => RoomModel.fromJson(e),
      ));
    } else {
      throw ServerException(errorMessage: resp.data);
    }
  }

  @override
  Future<UserModel> getRoomCreator(String roomId) async {
    final resp = await _dio.get("users/id/${roomId}");
    if (resp.statusCode == 200) {
      return UserModel.fromJson(resp.data);
    } else {
      throw ServerException(errorMessage: "User not found");
    }
  }

  @override
  Future<List<RoomModel>> getRoomsByCategory(String category) async {
    final resp =
        await _dio.get("${AppConstants.apiUrl}rooms/category/${category}");
    if (resp.statusCode == 200) {
      return List<RoomModel>.from((resp.data as List).map(
        (e) => RoomModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessage: resp.statusMessage ?? "probleme  rooms by category");
    }
  }

  @override
  Future<List<RoomModel>> getRoomsByKeyword(String keyword) async {
    final resp =
        await _dio.get("${AppConstants.apiUrl}rooms/search?key=${keyword}");
    if (resp.statusCode == 200) {
      return List<RoomModel>.from((resp.data as List).map(
        (e) => RoomModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessage: resp.statusMessage ?? "probleme  rooms by keyword");
    }
  }

  @override
  Future<List<RoomModel>> getPopularRooms() {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getRoomMembers(String roomId) {
    throw UnimplementedError();
  }

  @override
  Future<List<RoomModel>> getRoomsByDate(DateTime date) {
    throw UnimplementedError();
  }

  @override
  Future<RoomModel> saveRoomToFavorite(String roomId) {
    throw UnimplementedError();
  }
}
