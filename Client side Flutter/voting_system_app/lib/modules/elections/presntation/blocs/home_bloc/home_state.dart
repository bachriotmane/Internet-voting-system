// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeActionState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  List<Room> rooms;
  HomeLoadedSuccessState({
    required this.rooms,
  });
}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  String message;
  HomeErrorState({
    required this.message,
  });
}

class HomeSearchingState extends HomeState {
  final List<Room> rooms;

  HomeSearchingState({
    required this.rooms,
  });
}

class HomeNavigateToCategoryRoomsPageActionsState extends HomeActionState {
  List<Room> rooms;
  HomeNavigateToCategoryRoomsPageActionsState({
    required this.rooms,
  });
}
