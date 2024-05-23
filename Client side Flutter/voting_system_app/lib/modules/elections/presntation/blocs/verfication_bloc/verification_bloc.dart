import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<VerficationInitialEvent>(verficationInitialEvent);
    on<VerificationSubmitButtonClickedEvent>(
        verificationSubmitButtonClickedEvent);
  }

  FutureOr<void> verficationInitialEvent(
      VerficationInitialEvent event, Emitter<VerificationState> emit) {
    emit(VerificationSuccessState());
  }

  FutureOr<void> verificationSubmitButtonClickedEvent(
      VerificationSubmitButtonClickedEvent event,
      Emitter<VerificationState> emit) {
    if (event.providedCode == event.room.code) {
      emit(VerificationNavigateToRoomPageActionState(room: event.room));
    } else {
      emit(VerificationBadCodeActionState());
    }
  }
}
