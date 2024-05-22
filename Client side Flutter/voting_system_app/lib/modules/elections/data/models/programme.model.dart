import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';

class ProgrammeModel extends Programme {
  ProgrammeModel(
      {required super.programmeId,
      required super.programmeTitle,
      required super.programmeDesc,
      required super.creationDate,
      required super.roomId,
      required super.votes,
      required super.creatorId});

  factory ProgrammeModel.fromJson(Map<String, dynamic> json) => ProgrammeModel(
        programmeId: json["programmeId"],
        programmeTitle: json["programmeTitle"],
        programmeDesc: json["programmeDescription"],
        creationDate: DateTime.parse(json["creationDate"]),
        roomId: json["programmeRoom"],
        votes: json["voteIds"] as List,
        creatorId: json["creatorUserName"],
      );

  Map<String, dynamic> toJSON() => {
        "programmeId": programmeId,
        "programmeTitle": programmeTitle,
        "programmeDescription": programmeDesc,
        "creationDate": creationDate,
        "programmeRoom": roomId,
        "voteIds": votes,
        "creatorUserName": creatorId,
      };
}
