// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'roompage_bloc.dart';

@immutable
sealed class RoompageEvent {}

class RoomPageInitiaEvent extends RoompageEvent {
  String currentRoomId;
  RoomPageInitiaEvent({
    required this.currentRoomId,
  });
}

class RoompageVoteButtonClickedEvent extends RoompageEvent {
  final String programmeId;
  RoompageVoteButtonClickedEvent({
    required this.programmeId,
  });
}
