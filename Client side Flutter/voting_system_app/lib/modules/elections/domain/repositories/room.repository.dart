import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/data/model/user.model.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

abstract class RoomRepository {
  Either<Failure, Future<List<Room>>> getAllRooms();
  Either<Failure, Future<List<Room>>> getRoomsByKeyword(String keyword);
  Either<Failure, Future<List<Room>>> getRoomsByCategory(String category);
  Either<Failure, Future<List<Room>>> getRoomsByDate(DateTime date);
  Either<Failure, Future<List<Room>>> getPopularRooms();
  Either<Failure, Future<Room>> createRoom(RoomModel room);
  Either<Failure, Future<Room>> saveRoomToFavorite(String roomId);
  Either<Failure, Future<List<User>>> getRoomMembers(String roomId);
  Either<Failure, Future<User>> getRoomCreator(String roomId);
}
