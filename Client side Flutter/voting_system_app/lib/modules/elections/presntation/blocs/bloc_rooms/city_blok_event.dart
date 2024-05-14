part of 'city_blok_bloc.dart';

sealed class RoomBlocEvent extends Equatable {
  const RoomBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadRooms extends RoomBlocEvent {
  final List<RoomModel> rooms;

  const LoadRooms({this.rooms = const <RoomModel>[]});
  @override
  List<Object> get props => [rooms];

  @override
  bool? get stringify => throw UnimplementedError();
}

class AddRoomEvent extends RoomBlocEvent {
  final RoomModel room;
  const AddRoomEvent({required this.room});
  @override
  List<Object> get props => [room];

  @override
  bool? get stringify => throw UnimplementedError();
}
