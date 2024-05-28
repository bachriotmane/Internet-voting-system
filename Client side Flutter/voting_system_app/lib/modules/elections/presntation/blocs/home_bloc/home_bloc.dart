import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/common/utils/dummydata/dummy.data.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/room.repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeTypingEvent>(homeTypingEvent);
    on<HomeCategoryClickedEvent>(homeCategoryClickedEvent);
    on<HomeSaveButtonClickedEvent>(homeSaveButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final resp = await serviceLocatorElection<RoomRepository>().getAllRooms();
    resp.fold(
      (l) {
        emit(HomeErrorState(message: l.message));
      },
      (r) {
        emit(HomeLoadedSuccessState(rooms: r));
      },
    );
  }

  FutureOr<void> homeTypingEvent(
      HomeTypingEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final resp = await serviceLocatorElection<RoomRepository>()
        .getRoomsByKeyword(event.keyword);
    resp.fold(
      (l) {
        emit(HomeErrorState(message: l.message));
      },
      (r) {
        emit(HomeSearchingState(rooms: r));
      },
    );
  }

  FutureOr<void> homeCategoryClickedEvent(
      HomeCategoryClickedEvent event, Emitter<HomeState> emit) async {
    final resp = await serviceLocatorElection<RoomRepository>()
        .getRoomsByCategory(event.category);
    resp.fold(
      (l) {
        emit(HomeErrorState(message: l.message));
      },
      (r) {
        emit(HomeNavigateToCategoryRoomsPageActionsState(rooms: r));
      },
    );
  }

  FutureOr<void> homeSaveButtonClickedEvent(
      HomeSaveButtonClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    bool isSaved = false;
    for (Room r in TestData.savedRooms) {
      if (r.roomId == event.clickedRoom.roomId) {
        isSaved = true;
      }
    }
    print("Bloc isSaved $isSaved");
    if (!isSaved) {
      TestData.savedRooms.add(event.clickedRoom);
    } else {
      TestData.savedRooms.removeWhere(
        (element) => element.roomId == event.clickedRoom.roomId,
      );
    }
    final resp = await serviceLocatorElection<RoomRepository>().getAllRooms();
    emit(HomeRoomSavedSuccesfullyActionState());
    resp.fold(
      (l) {
        emit(HomeErrorState(message: l.message));
      },
      (r) {
        emit(HomeLoadedSuccessState(rooms: r));
      },
    );
  }
}
