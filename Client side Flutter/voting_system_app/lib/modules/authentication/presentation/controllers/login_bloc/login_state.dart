part of 'login_bloc.dart';

sealed class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedSuccessState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginVisiblePasswordBtnClickedState extends LoginState {}

class LoginWithBadCredentialsState extends LoginActionState {}

class LoginSucessState extends LoginActionState {}

class LoginRefreshTokenExpireActionState extends LoginActionState {}
