import 'dart:math';

import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

class RoomModel extends Room {
  final String image = "https://picsum.photos/200/300";

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

  Map<String, dynamic> toJSON() => {
        "title": roomTitle,
        "roomDescription": roomDesc,
        "createdAt": createAt,
        "startAt": startAt,
        "expiredAt": expireAt,
        "code": AppConstants.generateRandomCode(6)
      };
  factory RoomModel.fromJSON(Map<String, dynamic> json) => RoomModel(
      roomId: json["id"],
      creatorId: json[""],
      members: json[""],
      programmes: json[""],
      roomTitle: json['title'],
      roomDesc: json['roomDescription'],
      createAt: json['createdAt'],
      startAt: json['startAt'],
      expireAt: json['expiredAt'],
      code: json['code']);
}
