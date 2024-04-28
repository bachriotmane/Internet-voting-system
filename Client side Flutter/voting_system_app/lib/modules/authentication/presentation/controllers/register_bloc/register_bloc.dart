import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/authentication/domain/usecase/add.user.usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterInitialEvent>(registerInitialEvent);
    on<RegisterVisiblePasswordBtnClickedEvent>(
        registerVisiblePasswordBtnClickedEvent);
    on<RegisterNavigateToVerficationCodePageEvent>(
        registerNavigateToVerficationCodePageEvent);
    on<RegisterSubmitFormButtonClickedEvent>(
        registerSubmitFormButtonClickedEvent);
  }

  FutureOr<void> registerInitialEvent(
      RegisterInitialEvent event, Emitter<RegisterState> emit) {
    emit(RegisterLoadedSuccessState());
  }

  FutureOr<void> registerVisiblePasswordBtnClickedEvent(
      RegisterVisiblePasswordBtnClickedEvent event,
      Emitter<RegisterState> emit) {
    emit(RegisterVisiblePasswordBtnClickedState());
  }

  FutureOr<void> registerNavigateToVerficationCodePageEvent(
      RegisterNavigateToVerficationCodePageEvent event,
      Emitter<RegisterState> emit) {
    emit(RegisterNavigateToVerficationCodePageActionState());
  }

  FutureOr<void> registerSubmitFormButtonClickedEvent(
      RegisterSubmitFormButtonClickedEvent event,
      Emitter<RegisterState> emit) async {
    AddUserUsecase addUser = serviceLocator<AddUserUsecase>();
    emit(RegisterLoadingState());
    final result = await addUser.execute(event.user);
    result.fold(
      (l) => emit(RegisterErrorState()),
      (r) => emit(RegisterNavigateToVerficationCodePageActionState()),
    );
  }
}
