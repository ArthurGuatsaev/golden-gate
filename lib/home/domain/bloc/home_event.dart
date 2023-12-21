part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class ChangeHomeIndexEvent extends HomeEvent {
  final int homeIndex;
  const ChangeHomeIndexEvent({required this.homeIndex});
}

class ChangeLessonsIndex extends HomeEvent {
  final int index;
  const ChangeLessonsIndex({required this.index});
}

class ChangeLessonsItemIndex extends HomeEvent {
  final bool next;
  const ChangeLessonsItemIndex({required this.next});
}

class ActiveTestResultEvent extends HomeEvent {
  final bool result;
  final int index;
  const ActiveTestResultEvent({required this.result, required this.index});
}

class ChangeTermsTestIndex extends HomeEvent {
  final bool next;
  const ChangeTermsTestIndex({required this.next});
}

class ChangeTermsIndex extends HomeEvent {
  final bool next;
  const ChangeTermsIndex({required this.next});
}

class StatusWinEvent extends HomeEvent {
  final MyTestStatus status;
  const StatusWinEvent({required this.status});
}

class ChangeViewAllEvent extends HomeEvent {}

class StartTestEvent extends HomeEvent {}

class GetTermsEvent extends HomeEvent {}

class TestAgainEvent extends HomeEvent {}

class RessetTestEvent extends HomeEvent {}

class NextLessonEvent extends HomeEvent {}

class MixTermsEvent extends HomeEvent {}
