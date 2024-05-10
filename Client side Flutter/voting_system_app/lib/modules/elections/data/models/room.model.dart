import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

class RoomModel extends Room {
  RoomModel(
      {required super.roomId,
      required super.roomTitle,
      required super.roomDesc,
      required super.createAt,
      required super.startAt,
      required super.expireAt,
      required super.code,
      required super.members,
      required super.creatorId,
      required super.programmes});
}
