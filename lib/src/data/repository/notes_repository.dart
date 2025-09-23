import 'package:notebook/src/model/note_model.dart';

abstract class NotesRepository {
  Future<List<Note>> fetchNotes();
  Future<Note> fetchNoteById(String id);
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNoteById(String id);
}
