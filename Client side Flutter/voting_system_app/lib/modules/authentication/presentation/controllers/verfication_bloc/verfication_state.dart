part of 'verfication_bloc.dart';

@immutable
sealed class VerficationState {}

class VerficationActionState extends VerficationState {}

final class VerficationInitial extends VerficationState {}

class VerficationLoadedSucessState extends VerficationState {}

class VerficationErrorState extends VerficationActionState {
  final String errorMsg;

  VerficationErrorState({required this.errorMsg});
}

class VerficationNavigateToLoginPageActionState
    extends VerficationActionState {}
