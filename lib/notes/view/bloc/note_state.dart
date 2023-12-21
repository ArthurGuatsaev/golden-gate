// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

class NoteState {
  final List<VNotesIssar> notes;
  final int currentId;
  final Uint8List? postImage;
  NoteState({
    this.notes = const [],
    this.currentId = 0,
    this.postImage,
  });

  NoteState copyWith({
    List<VNotesIssar>? notes,
    int? currentId,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      currentId: currentId ?? this.currentId,
    );
  }

  List<VNotesIssar> get currentNotes {
    if (notes.isEmpty) {
      return [];
    }
    return notes.where((element) => element.iD == currentId).toList();
  }
}
