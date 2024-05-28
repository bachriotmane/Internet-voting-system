import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/elections/data/models/vote.model.dart';
import 'package:voting_system_app/modules/elections/domain/entities/programme.dart';
import 'package:voting_system_app/modules/elections/domain/entities/vote.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/programme.repository.dart';
import 'package:voting_system_app/modules/elections/domain/repositories/vote.repository.dart';
import 'package:get_storage/get_storage.dart';
part 'roompage_event.dart';
part 'roompage_state.dart';

class RoompageBloc extends Bloc<RoompageEvent, RoompageState> {
  RoompageBloc() : super(RoompageInitial()) {
    on<RoomPageInitiaEvent>(roomPageInitiaEvent);
    on<RoompageVoteButtonClickedEvent>(roompageVoteButtonClickedEvent);
  }

  FutureOr<void> roomPageInitiaEvent(
      RoomPageInitiaEvent event, Emitter<RoompageState> emit) async {
    // String loggedUser = "moha123";
    String loggedUser = GetStorage().read("loged-user");
    emit(RoomPageLoadingState());
    final resp = await serviceLocatorElection<ProgrammeRepository>()
        .getRoomProgrammes(event.currentRoomId);
    String programmeId = "";
    final resp2 = await serviceLocatorElection<VoteRepository>().getAllVotes();
    resp2.fold(
      (l) {
        emit(RoompageErrorState(message: l.message));
      },
      (r) {
        for (Vote v in r) {
          print(v.voterId + ": voter | id :" + v.id);
          if (v.voterId == loggedUser) {
            programmeId = v.votedProgramme;
          }
        }
      },
    );
    resp.fold(
      (l) {
        emit(RoompageErrorState(message: l.message));
      },
      (r) async {
        emit(RoomPageLoadedSuccesState(
            programmes: r, currentUserVotedId: programmeId));
      },
    );
  }

  FutureOr<void> roompageVoteButtonClickedEvent(
      RoompageVoteButtonClickedEvent event, Emitter<RoompageState> emit) async {
    // String loggedUser = "moha123";
    String loggedUser = GetStorage().read("loged-user");
    emit(RoomPageLoadingState());
    //! Get votes for this programme
    //! If the current user already vote ==> update
    //! Else create a new vote

    String? programmeVoted = null;
    final programmeVotesResp = await serviceLocatorElection<VoteRepository>()
        .getProgrammeVotes(event.programmeId);
    print("Prorgamm Vote :" + event.programmeId);
    programmeVotesResp.fold(
      (l) => emit(RoompageErrorState(message: l.message + " Hij")),
      (r) {
        for (Vote v in r) {
          if (v.voterId == loggedUser) {
            programmeVoted = v.id;
            break;
          }
        }
      },
    );

    if (programmeVoted != null) {
      print("~~Not null");
      VoteModel v = VoteModel(
        id: programmeVoted!,
        date: DateTime.now(),
        voterId: loggedUser,
        votedProgramme: event.programmeId,
      );
      final resp = await serviceLocator<Dio>().put(
        "${AppConstants.apiUrl}votes",
        data: {
          "voteId": programmeVoted,
          "voterId": loggedUser,
          "programmeId": event.programmeId,
          "voteDate": DateTime.now(),
        },
      );
      print(v.toJSON());
      if (resp.statusCode == 200) {
        emit(RoompageProgrammeVotedSuccesfullyActionState());
      } else {
        emit(RoompageErrorState(message: resp.data));
      }
    } else {
      print("~~Null");
      VoteModel vote = VoteModel(
        id: "",
        date: DateTime.now(),
        voterId: loggedUser,
        votedProgramme: event.programmeId,
      );
      final saveVoteResp = await serviceLocatorElection<VoteRepository>()
          .saveVoteProgramme(vote);
      saveVoteResp.fold(
        (l) => emit(RoompageErrorState(message: l.message)),
        (r) => emit(RoompageProgrammeVotedSuccesfullyActionState()),
      );
    }
  }
}
