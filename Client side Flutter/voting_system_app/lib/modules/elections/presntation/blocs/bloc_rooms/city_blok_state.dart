part of 'city_blok_bloc.dart';

sealed class RoomBlocStat extends Equatable {
  const RoomBlocStat();

  @override
  List<Object> get props => [];
}

class RoomsLoading extends RoomBlocStat {
  @override
  bool? get stringify => throw UnimplementedError();
}

class RoomsLoaded extends RoomBlocStat {
  final List<RoomModel> rooms;

  const RoomsLoaded({this.rooms = const <RoomModel>[]});

  @override
  List<Object> get props => [rooms];

  @override
  bool? get stringify => throw UnimplementedError();
}
