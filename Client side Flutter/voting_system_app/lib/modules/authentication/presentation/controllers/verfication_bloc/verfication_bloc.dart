import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/activation.dart';
import 'package:voting_system_app/modules/authentication/domain/usecase/activation.usecase.dart';

part 'verfication_event.dart';
part 'verfication_state.dart';

class VerficationBloc extends Bloc<VerficationEvent, VerficationState> {
  VerficationBloc() : super(VerficationInitial()) {
    on<VeficationInitialEvent>(veficationInitialEvent);
    on<VerficationActivateAccountEvent>(verficationActivateAccountEvent);
  }

  FutureOr<void> veficationInitialEvent(
      VeficationInitialEvent event, Emitter<VerficationState> emit) {
    emit(VerficationLoadedSucessState());
  }

  FutureOr<void> verficationActivateAccountEvent(
      VerficationActivateAccountEvent event,
      Emitter<VerficationState> emit) async {
    String code = event.code;
    final activeAccount = serviceLocator<ActivationUsecase>();
    final isActivated = await activeAccount.execute(Activation(code: code));

    isActivated.fold(
      (l) => emit(VerficationErrorState(errorMsg: l.message)),
      (r) => emit(VerficationNavigateToLoginPageActionState()),
    );
  }
}
