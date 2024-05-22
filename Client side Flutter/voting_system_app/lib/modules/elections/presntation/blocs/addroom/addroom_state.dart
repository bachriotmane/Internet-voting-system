// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'addroom_bloc.dart';

@immutable
sealed class AddroomState {}

final class AddroomInitial extends AddroomState {}

class AddroomActionState extends AddroomState {}

class AddroomLoadingState extends AddroomState {}

class AddroomLoadedSuccessState extends AddroomState {}

class AddroomErrorState extends AddroomState {
  String message;
  AddroomErrorState({
    required this.message,
  });
}

class AddRoomNavigateToHomePageActionState extends AddroomActionState {}

class AddroomRoomAddedSuccessfullyActionState extends AddroomActionState {}
