// ignore_for_file: public_member_api_docs, sort_constructors_first
class Programme {
  String programmeId;
  String programmeTitle;
  String programmeDesc;
  DateTime creationDate;
  String roomId;
  String creatorId;
  List votes;
  Programme({
    required this.programmeId,
    required this.programmeTitle,
    required this.programmeDesc,
    required this.creationDate,
    required this.roomId,
    required this.votes,
    required this.creatorId,
  });
}
