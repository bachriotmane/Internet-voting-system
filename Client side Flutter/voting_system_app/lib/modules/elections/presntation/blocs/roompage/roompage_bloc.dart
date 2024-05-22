import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';
import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/programme.repository.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/vote.repository.dart';

part 'roompage_event.dart';
part 'roompage_state.dart';

class RoompageBloc extends Bloc<RoompageEvent, RoompageState> {
  RoompageBloc() : super(RoompageInitial()) {
    on<RoomPageInitiaEvent>(roomPageInitiaEvent);
    on<RoompageVoteButtonClickedEvent>(roompageVoteButtonClickedEvent);
  }

  FutureOr<void> roomPageInitiaEvent(
      RoomPageInitiaEvent event, Emitter<RoompageState> emit) async {
    emit(RoomPageLoadingState());
    final resp = await serviceLocatorElection<ProgrammeRepository>()
        .getRoomProgrammes(event.currentRoomId);

    resp.fold(
      (l) {
        emit(RoompageErrorState(message: l.message));
      },
      (r) {
        emit(RoomPageLoadedSuccesState(programmes: r));
      },
    );
  }

  FutureOr<void> roompageVoteButtonClickedEvent(
      RoompageVoteButtonClickedEvent event, Emitter<RoompageState> emit) async {
    emit(RoomPageLoadingState());
    Vote vote = Vote(
      id: "",
      date: DateTime.now(),
      voterId: GetStorage().read("loged-user"),
      votedProgramme: event.programmeId,
    );
    final resp =
        await serviceLocatorElection<VoteRepository>().saveVoteProgramme(vote);
    resp.fold(
      (l) {
        emit(RoompageErrorState(message: l.message));
      },
      (r) {
        emit(RoompageProgrammeVotedSuccesfullyActionState());
      },
    );
  }
}
