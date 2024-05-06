// ignore_for_file: public_member_api_docs, sort_constructors_first
class Room {
  String roomId;
  String roomTitle;
  String roomDesc;
  DateTime createAt;
  DateTime startAt;
  DateTime expireAt;
  String code;
  List<String> members;
  String creatorId;
  List<String> programmes;
  Room({
    required this.roomId,
    required this.roomTitle,
    required this.roomDesc,
    required this.createAt,
    required this.startAt,
    required this.expireAt,
    required this.code,
    required this.members,
    required this.creatorId,
    required this.programmes,
  });
}
