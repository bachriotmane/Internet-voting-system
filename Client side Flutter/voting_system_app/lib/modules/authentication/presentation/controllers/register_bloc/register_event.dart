// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

sealed class RegisterEvent {}

class RegisterInitialEvent extends RegisterEvent {}

class RegisterVisiblePasswordBtnClickedEvent extends RegisterEvent {}

class RegisterNavigateToVerficationCodePageEvent extends RegisterEvent {}

class RegisterSubmitFormButtonClickedEvent extends RegisterEvent {
  User user;
  RegisterSubmitFormButtonClickedEvent({
    required this.user,
  });
}
