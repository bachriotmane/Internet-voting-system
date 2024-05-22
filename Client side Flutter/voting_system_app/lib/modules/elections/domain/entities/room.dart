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
  String creatorUserName;
  List<String> programmes;
  String category;
  Room({
    required this.roomId,
    required this.roomTitle,
    required this.roomDesc,
    required this.createAt,
    required this.startAt,
    required this.expireAt,
    required this.code,
    required this.members,
    required this.creatorUserName,
    required this.programmes,
    required this.category,
  });
}
