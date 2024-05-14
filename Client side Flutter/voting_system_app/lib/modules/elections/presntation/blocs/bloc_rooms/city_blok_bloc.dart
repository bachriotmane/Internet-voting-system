import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';

part 'city_blok_event.dart';
part 'city_blok_state.dart';

class RoomBloc extends Bloc<RoomBlocEvent, RoomBlocStat> {
  RoomBloc() : super(RoomsLoading()) {
    on<LoadRooms>(_onLoadRooms);
    on<AddRoomEvent>(_onAddRoom);
  }

  FutureOr<void> _onLoadRooms(LoadRooms event, Emitter<RoomBlocStat> emit) {
    emit(
      RoomsLoaded(rooms: event.rooms),
    );
  }

  FutureOr<void> _onAddRoom(AddRoomEvent event, Emitter<RoomBlocStat> emit) {
    final state = this.state;
    if (state is RoomsLoaded) {
      emit(RoomsLoaded(
        rooms: List.from(state.rooms)..add(event.room),
      ));
    }
  }
}
