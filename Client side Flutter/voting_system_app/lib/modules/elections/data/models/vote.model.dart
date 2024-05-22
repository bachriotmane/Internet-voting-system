import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';

class VoteModel extends Vote {
  VoteModel(
      {required super.id,
      required super.date,
      required super.voterId,
      required super.votedProgramme});

  Map<String, dynamic> toJSON() => {
        "voteDate": date.toIso8601String(),
        "voterId": voterId,
        "programmeId": votedProgramme,
      };
  factory VoteModel.fromJSON(Map<String, dynamic> json) => VoteModel(
        id: json['voteId'],
        date: DateTime.parse(json['voteDate']),
        votedProgramme: json['programmeId'],
        voterId: json['voterId'],
      );
}
