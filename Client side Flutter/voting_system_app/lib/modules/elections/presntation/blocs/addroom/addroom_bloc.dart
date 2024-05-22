import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/modules/elections/data/models/room.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';

part 'addroom_event.dart';
part 'addroom_state.dart';

class AddroomBloc extends Bloc<AddroomEvent, AddroomState> {
  AddroomBloc() : super(AddroomInitial()) {
    on<AddroomInitialEvent>(addroomInitialEvent);
    on<AddroomCreateButtonClickedEvent>(addroomCreateButtonClickedEvent);
  }

  FutureOr<void> addroomInitialEvent(
      AddroomInitialEvent event, Emitter<AddroomState> emit) {
    emit(AddroomLoadedSuccessState());
  }

  FutureOr<void> addroomCreateButtonClickedEvent(
      AddroomCreateButtonClickedEvent event, Emitter<AddroomState> emit) async {
    emit(AddroomLoadingState());
    final resp =
        await serviceLocatorElection<RoomRepository>().createRoom(RoomModel(
      roomId: event.room.roomId,
      roomTitle: event.room.roomTitle,
      roomDesc: event.room.roomDesc,
      createAt: event.room.createAt,
      startAt: event.room.startAt,
      expireAt: event.room.expireAt,
      code: event.room.code,
      members: event.room.members,
      creatorUserName: event.room.creatorUserName,
      programmes: event.room.programmes,
      category: event.room.category,
    ));
    print("Created");
    resp.fold(
      (l) {
        emit(AddroomErrorState(message: l.message));
      },
      (r) {
        emit(AddroomRoomAddedSuccessfullyActionState());
      },
    );
    //
  }
}
