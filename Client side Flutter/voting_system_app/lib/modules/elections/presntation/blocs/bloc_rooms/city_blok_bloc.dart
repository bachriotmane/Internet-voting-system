import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/data/repositories/room.repository,impl.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';

part 'city_blok_event.dart';
part 'city_blok_state.dart';

class RoomBloc extends Bloc<RoomBlocEvent, RoomBlocStat> {
  RoomBloc() : super(RoomsLoading()) {
    on<LoadRooms>(_onLoadRooms);
    on<AddRoomEvent>(_onAddRoom);
  }

  FutureOr<void> _onLoadRooms(
      LoadRooms event, Emitter<RoomBlocStat> emit) async {
    emit(RoomsLoading());
    final resp = await serviceLocatorElection<RoomRepository>().getAllRooms();
    resp.fold(
      (l) {},
      (r) => emit(RoomsLoaded(rooms: r)),
    );
  }

  FutureOr<void> _onAddRoom(
      AddRoomEvent event, Emitter<RoomBlocStat> emit) async {
    emit(RoomsLoading());
    final resp =
        await serviceLocatorElection<RoomRepository>().addRoom(event.room);
    resp.fold(
      (l) {},
      (r) => emit(RoomsLoaded()),
    );
  }
}
