import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

abstract class RoomRepository {
  Future<Either<Failure, List<RoomModel>>> getAllRooms();
  Future<Either<Failure, bool>> addRoom(Room room);
}
