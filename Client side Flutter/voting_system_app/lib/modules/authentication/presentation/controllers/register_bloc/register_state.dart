// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

sealed class RegisterState {}

abstract class RegisterActionState extends RegisterState {}

final class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {}

class RegisterVisiblePasswordBtnClickedState extends RegisterState {}

class RegisterNavigateToVerficationCodePageActionState
    extends RegisterActionState {}
