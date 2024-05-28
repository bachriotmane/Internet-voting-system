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
    required super.creatorUserName,
    required super.programmes,
    required super.category,
  });

  Map<String, dynamic> toJson() => {
        "title": this.roomTitle,
        "roomDescription": roomDesc,
        "createAt": createAt.toIso8601String(),
        "startAt": startAt.toIso8601String(),
        "expireAt": expireAt.toIso8601String(),
        "code": code,
        "roomMembersId": members,
        "roomCreator": creatorUserName,
        "programmeListId": programmes,
        "category": category,
      };
  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        roomId: json['roomId'],
        roomTitle: json['title'],
        roomDesc: json['roomDescription'],
        code: json['code'],
        creatorUserName: json['roomCreator'],
        createAt: DateTime.parse(json["createAt"]),
        expireAt: DateTime.parse(json["expireAt"]),
        startAt: DateTime.parse(json["startAt"]),
        members: [],
        programmes: [],
        category: json["category"] ?? "default",
      );
}
