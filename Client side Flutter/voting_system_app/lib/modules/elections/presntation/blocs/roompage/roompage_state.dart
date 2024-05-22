// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'roompage_bloc.dart';

@immutable
sealed class RoompageState {}

final class RoompageInitial extends RoompageState {}

class RoompageActionsState extends RoompageState {}

class RoomPageLoadedSuccesState extends RoompageState {
  List<Programme> programmes;
  RoomPageLoadedSuccesState({
    required this.programmes,
  });
}

class RoomPageLoadingState extends RoompageState {}

class RoompageErrorState extends RoompageState {
  String message;
  RoompageErrorState({
    required this.message,
  });
}

class RoompageProgrammeVotedSuccesfullyActionState
    extends RoompageActionsState {}
