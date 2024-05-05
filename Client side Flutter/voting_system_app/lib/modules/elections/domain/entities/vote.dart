// ignore_for_file: public_member_api_docs, sort_constructors_first
class Vote {
  String id;
  DateTime date;
  String voterId;
  String votedProgramme;
  Vote({
    required this.id,
    required this.date,
    required this.voterId,
    required this.votedProgramme,
  });
}
