import 'package:dartz/dartz.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';

import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/modules/elections/data/datasource/room.datasource.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';

class RoomRepositoryImpl extends RoomRepository {
  final RoomDataSource roomDataSource;
  RoomRepositoryImpl({
    required this.roomDataSource,
  });

  @override
  Future<Either<Failure, bool>> addRoom(Room room) async {
    try {
      final result = await roomDataSource.addRoom(RoomModel(
          roomId: room.roomId,
          roomTitle: room.roomTitle,
          roomDesc: room.roomDesc,
          createAt: room.createAt,
          startAt: room.startAt,
          expireAt: room.expireAt,
          code: "",
          members: [],
          creatorId: "", // to do get the user id from localstorage
          programmes: []));
      return right(result);
    } on ServerException catch (err) {
      return left(ServerFailure(message: err.errorMessage));
    } catch (exp) {
      return left(Failure(message: exp.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RoomModel>>> getAllRooms() async {
    try {
      final result = await roomDataSource.getAllRooms();
      return Right(result);
    } on ServerException catch (err) {
      return left(ServerFailure(message: err.errorMessage));
    } catch (exp) {
      return left(Failure(message: exp.toString()));
    }
  }
}
