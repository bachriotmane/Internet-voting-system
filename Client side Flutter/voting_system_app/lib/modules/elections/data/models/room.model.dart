import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

class RoomModel extends Room {
  RoomModel({
    required super.roomId,
    required super.roomTitle,
    required super.roomDesc,
    required super.createAt,
    required super.startAt,
    required super.expireAt,
    required super.code,
    required super.members,
    required super.creatorId,
    required super.programmes,
  });

  Map<String, dynamic> toJson() => {};
  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        roomId: json['roomId'],
        roomTitle: json['title'],
        roomDesc: json['roomDescription'],
        code: json['code'],
        creatorId: json['roomCreatorId'],
        createAt: DateTime.now(),
        expireAt: DateTime.now(),
        startAt: DateTime.now(),
        members: [],
        programmes: [],
      );
}
