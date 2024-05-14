import 'package:voting_system_app/modules/elections/data/models/room.model.dart';

abstract class RoomDataSource {
  Future<List<RoomModel>> getAllRooms();
  Future<bool> addRoom(RoomModel roomModel);
}
