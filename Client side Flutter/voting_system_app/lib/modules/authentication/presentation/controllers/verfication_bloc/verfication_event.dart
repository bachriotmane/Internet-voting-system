// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verfication_bloc.dart';

@immutable
sealed class VerficationEvent {}

class VeficationInitialEvent extends VerficationEvent {}

// ignore: must_be_immutable
class VerficationActivateAccountEvent extends VerficationEvent {
  String code;
  VerficationActivateAccountEvent({
    required this.code,
  });
}
