// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'load_bloc.dart';

abstract class LoadEvent {
  const LoadEvent();
}

class CheckRepoInitEvent extends LoadEvent {
  final bool isDead;
  CheckRepoInitEvent({
    required this.isDead,
  });
}

class FirebaseRemoteInitEvent extends LoadEvent {}

class OnBoardCheckEvent extends LoadEvent {
  final String udid;
  final int procentChargh;
  final bool isChargh;
  final bool isVpn;
  final bool isDead;
  OnBoardCheckEvent({
    required this.isDead,
    required this.udid,
    required this.procentChargh,
    required this.isChargh,
    required this.isVpn,
  });
}

class UserRepoInitEvent extends LoadEvent {}

// class PostRepoInitEvent extends LoadEvent {}

class LessonsRepoInitEvent extends LoadEvent {}

class TermRepoInitEvent extends LoadEvent {}

class VideoRepoInitEvent extends LoadEvent {}

class NoteRepoInitEvent extends LoadEvent {}

class NFTRepoInitEvent extends LoadEvent {}

class TopNFTRepoInitEvent extends LoadEvent {}

class LessonRepoInitEvent extends LoadEvent {}

class BankRepoInitEvent extends LoadEvent {}

class NewsRepoInitEvent extends LoadEvent {}

class SaveUrlEvent extends LoadEvent {
  final String url;
  const SaveUrlEvent({
    required this.url,
  });
}

class LoadingProgressEvent extends LoadEvent {
  final VLoading event;
  LoadingProgressEvent({required this.event});
}

class ChangeOnbIndicatorEvent extends LoadEvent {
  final int index;
  const ChangeOnbIndicatorEvent({required this.index});
}
