// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'verification_bloc.dart';

@immutable
sealed class VerificationEvent {}

class VerficationInitialEvent extends VerificationEvent {}

class VerificationSubmitButtonClickedEvent extends VerificationEvent {
  Room room;
  String providedCode;
  VerificationSubmitButtonClickedEvent({
    required this.room,
    required this.providedCode,
  });
}
