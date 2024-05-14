import 'dart:math';

import 'package:voting_system_app/common/utils/constants/app.constants.dart';

class RoomModel {
  String roomTitle;
  String roomDesc;
  DateTime createAt;
  DateTime startAt;
  DateTime expireAt;
  final String code;
  final String image = "https://picsum.photos/200/300";
  RoomModel({
    required this.createAt,
    required this.expireAt,
    required this.roomDesc,
    required this.roomTitle,
    required this.startAt,
    required this.code,
  });

  Map<String, dynamic> toJSON() => {
        "title": roomTitle,
        "roomDescription": roomDesc,
        "createdAt": createAt,
        "startAt": startAt,
        "expiredAt": expireAt,
        "code": AppConstants.generateRandomCode(6)
      };
  factory RoomModel.fromJSON(Map<String, dynamic> json) => RoomModel(
      roomTitle: json['title'],
      roomDesc: json['roomDescription'],
      createAt: json['createdAt'],
      startAt: json['startAt'],
      expireAt: json['expiredAt'],
      code: json['code']);
}
