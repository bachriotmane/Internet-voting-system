import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

abstract class RoomRepository {
  Future<Either<Failure, List<Room>>> getAllRooms();
  Future<Either<Failure, List<Room>>> getRoomsByKeyword(String keyword);
  Future<Either<Failure, List<Room>>> getRoomsByCategory(String category);
  Future<Either<Failure, List<Room>>> getRoomsByDate(DateTime date);
  Future<Either<Failure, List<Room>>> getPopularRooms();
  Future<Either<Failure, Room>> createRoom(RoomModel room);
  Future<Either<Failure, Room>> saveRoomToFavorite(String roomId);
  Future<Either<Failure, List<User>>> getRoomMembers(String roomId);
  Future<Either<Failure, User>> getRoomCreator(String roomId);
}
