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
}
