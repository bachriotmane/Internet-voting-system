import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/elections/data/datasource/room.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';

class RoomRepositoryImpl extends RoomRepository {
  final RoomDataSource datasource;
  final Dio dio = serviceLocator<Dio>();
  RoomRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Room>>> getAllRooms() async {
    try {
      List<RoomModel> resp = await datasource.getAllRooms();
      return right(resp);
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getRoomCreator(String roomId) async {
    try {
      final resp = await datasource.getRoomCreator(roomId);
      User user = User(
        id: resp.id,
        username: resp.username,
        password: resp.password,
        location: resp.location,
        memeberSince: resp.memeberSince,
        email: resp.email,
      );
      return right(user);
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Room>>> getRoomsByCategory(
      String category) async {
    try {
      final resp = await datasource.getRoomsByCategory(category);
      return right(resp);
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Room>>> getRoomsByKeyword(String keyword) async {
    try {
      final resp = await datasource.getRoomsByKeyword(keyword);
      return right(resp);
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Room>> createRoom(RoomModel room) async {
    try {
      final resp = await datasource.createRoom(room);
      print("Room");
      return (right(resp));
    } catch (err) {
      return left(ServerFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getRoomMembers(String roomId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Room>>> getPopularRooms() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Room>>> getRoomsByDate(DateTime date) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Room>> saveRoomToFavorite(String roomId) {
    throw UnimplementedError();
  }
}
