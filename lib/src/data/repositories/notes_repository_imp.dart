import 'package:notebook/src/data/repositories/notes_repository.dart';
import 'package:notebook/src/data/services/local/data_base.dart';
import 'package:notebook/src/domain/models/note_model.dart';

class NotesRepositoryImp implements NotesRepository {
  final SqlDatabase sqlDatabase;

  NotesRepositoryImp({required this.sqlDatabase});

  @override
  Future<void> addNote(Note note) {
    return sqlDatabase.insert(note);
  }

  @override
  Future<void> deleteNoteById(int id) {
    return sqlDatabase.delete(id);
  }

  @override
  Future<Note?> fetchNoteById(int id) {
    return sqlDatabase.getNoteById(id);
  }

  @override
  Future<List<Note>> fetchNotes() {
    return sqlDatabase.getAllNotes();
  }

  @override
  Future<void> updateNote(Note note) {
    return sqlDatabase.update(note);
  }
}
