import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';

class VoteModel extends Vote {
  VoteModel(
      {required super.id,
      required super.date,
      required super.voterId,
      required super.votedProgramme});

  Map<String, dynamic> toJSON() => {};
  factory VoteModel.fromJSON(Map<String, dynamic> json) => VoteModel(
        id: json['id'],
        date: json['date'],
        votedProgramme: json[''],
        voterId: json[''],
      );
}
