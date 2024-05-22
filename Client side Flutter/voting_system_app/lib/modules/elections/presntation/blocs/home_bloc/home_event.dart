// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeTypingEvent extends HomeEvent {
  String keyword;
  HomeTypingEvent({
    required this.keyword,
  });
}

class HomeCategoryClickedEvent extends HomeEvent {
  String category;
  HomeCategoryClickedEvent({
    required this.category,
  });
}
