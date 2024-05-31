// ignore_for_file: must_be_immutable

part of 'verification_bloc.dart';

@immutable
sealed class VerificationState {}

final class VerificationInitial extends VerificationState {}

class VerificationActionState extends VerificationState {}

class VerificationSuccessState extends VerificationState {}

class VerificationLoadingState extends VerificationState {}

class VerificationErrorState extends VerificationState {
  final String message;

  VerificationErrorState(this.message);
}

class VerificationNavigateToRoomPageActionState
    extends VerificationActionState {
  Room room;
  VerificationNavigateToRoomPageActionState({required this.room});
}

class VerificationBadCodeActionState extends VerificationActionState {}
