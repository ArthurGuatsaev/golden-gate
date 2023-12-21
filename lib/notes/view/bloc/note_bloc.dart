import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import '../../import.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepo;
  NoteBloc({required this.noteRepo}) : super(NoteState()) {
    on<SaveNoteEvent>(onSaveNote);
    on<GetNotesEvent>(onGetNotes);
    on<DelNoteEvent>(onDelNote);
    on<UpdateNotesEvent>(onUpdateNotes);
    on<ChangeCurrentIdEvent>(onChangeCurrentId);
    on<ResetNoteEvent>(onResetNote);
  }

  onSaveNote(SaveNoteEvent event, Emitter<NoteState> emit) async {
    await noteRepo.saveNote(note: event.note);
    await noteRepo.getNoteUpdata();
    add(GetNotesEvent());
  }

  onResetNote(ResetNoteEvent event, Emitter<NoteState> emit) async {
    await noteRepo.reseteNote();
    await noteRepo.getNoteUpdata();
    add(GetNotesEvent());
  }

  onGetNotes(GetNotesEvent event, Emitter<NoteState> emit) async {
    if (noteRepo.notes != null) {
      final notes = [...noteRepo.notes!];
      emit(state.copyWith(notes: notes));
    }
  }

  onUpdateNotes(UpdateNotesEvent event, Emitter<NoteState> emit) async {
    await noteRepo.getNoteUpdata();
    final notes = noteRepo.notes;
    emit(state.copyWith(notes: notes));
  }

  onDelNote(DelNoteEvent event, Emitter<NoteState> emit) async {
    await noteRepo.deleteNote(event.note);
    add(UpdateNotesEvent());
  }

  onChangeCurrentId(ChangeCurrentIdEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(currentId: event.id));
  }
}
