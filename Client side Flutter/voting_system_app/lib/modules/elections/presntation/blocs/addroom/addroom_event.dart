// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'addroom_bloc.dart';

@immutable
sealed class AddroomEvent {}

class AddroomInitialEvent extends AddroomEvent {}

class AddroomCreateButtonClickedEvent extends AddroomEvent {
  Room room;
  AddroomCreateButtonClickedEvent({
    required this.room,
  });
}
