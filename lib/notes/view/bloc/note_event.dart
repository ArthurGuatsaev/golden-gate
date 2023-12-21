// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

abstract class NoteEvent {
  const NoteEvent();
}

class GetPostsEvent extends NoteEvent {}

class StreamNoteEvent extends NoteEvent {}

class GetNotesEvent extends NoteEvent {}

class UpdateNotesEvent extends NoteEvent {}

class PostImageEvent extends NoteEvent {}

class InitialPostEvent extends NoteEvent {}

class ResetNoteEvent extends NoteEvent {}

class AddPostsEvent extends NoteEvent {
  final String title;
  final String userToken;
  final String text;
  const AddPostsEvent({
    required this.title,
    required this.userToken,
    required this.text,
  });
}

class SaveNoteEvent extends NoteEvent {
  final VNotesIssar note;
  SaveNoteEvent({
    required this.note,
  });
}

class DelPostsEvent extends NoteEvent {
  final String userToken;
  final int id;
  DelPostsEvent({
    required this.userToken,
    required this.id,
  });
}

class ChangeCurrentIdEvent extends NoteEvent {
  final int id;
  ChangeCurrentIdEvent({
    required this.id,
  });
}

class FindCurrentPost extends NoteEvent {
  final int index;
  FindCurrentPost({
    required this.index,
  });
}

class DelNoteEvent extends NoteEvent {
  final VNotesIssar note;
  DelNoteEvent({
    required this.note,
  });
}
