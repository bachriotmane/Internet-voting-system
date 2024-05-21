import 'package:voting_system_app/modules/authentication/data/model/user.model.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';

abstract class RoomDataSource {
  Future<List<RoomModel>> getAllRooms();
  Future<List<RoomModel>> getRoomsByKeyword(String keyword);
  Future<List<RoomModel>> getRoomsByCategory(String category);
  Future<List<RoomModel>> getRoomsByDate(DateTime date);
  Future<List<RoomModel>> getPopularRooms();
  Future<RoomModel> createRoom(RoomModel room);
  Future<RoomModel> saveRoomToFavorite(String roomId);
  Future<List<UserModel>> getRoomMembers(String roomId);
  Future<UserModel> getRoomCreator(String roomId);
}
