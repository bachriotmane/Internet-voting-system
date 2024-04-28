// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginVisiblePasswordBtnClickedEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  String email;
  String password;
  LoginButtonClickedEvent({
    required this.email,
    required this.password,
  });
}
