import 'dart:async';
import 'package:isar/isar.dart';
import '../../loading/domain/model/loading_model.dart';
import '../import.dart';

class NoteRepository {
  final Isar isar;
  final StreamController<String> errorController;
  NoteRepository({required this.errorController, required this.isar});

  List<VNotesIssar>? notes;

  Future<List<VNotesIssar>> getNoteUpdata(
      {StreamController<VLoading>? controller}) async {
    notes = await isar.vNotesIssars.where().findAll();
    controller?.add(VLoading.notes);
    return notes ?? [];
  }

  Future<void> saveNote({required VNotesIssar note}) async {
    await isar.writeTxn(() async {
      await isar.vNotesIssars.put(note);
    });
  }

  Future<void> deleteNote(VNotesIssar note) async {
    await isar.writeTxn(() async {
      await isar.vNotesIssars.delete(note.id); // delete
    });
  }

  Future<void> reseteNote() async {
    await isar.writeTxn(() async {
      await isar.vNotesIssars.clear(); // resete
    });
  }
}
