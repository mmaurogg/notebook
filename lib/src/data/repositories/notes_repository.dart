import 'package:notebook/src/domain/models/note_model.dart';

abstract class NotesRepository {
  Future<List<Note>> fetchNotes();
  Future<Note?> fetchNoteById(int id);
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNoteById(int id);
}
