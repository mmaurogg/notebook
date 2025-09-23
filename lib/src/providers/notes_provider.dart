import 'package:flutter/material.dart';
import 'package:notebook/src/data/repository/notes_repository.dart';
import 'package:notebook/src/data/services/local/notes_repository_imp.dart';
import 'package:notebook/src/model/note_model.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepository _notesRepository = NotesRepositoryImp();

  //NotesProvider(this._notesRepository);

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await _notesRepository.fetchNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _notesRepository.addNote(note);
    _notes.add(note);
    notifyListeners();
  }

  Future<void> removeNote(Note note) async {
    await _notesRepository.deleteNoteById(note.id);
    _notes.removeWhere((n) => n.id == note.id);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await _notesRepository.updateNote(note);
    _notes.removeWhere((n) => n.id == note.id);
    _notes.add(note);
    notifyListeners();
  }

  Future<Note?> getNoteById(int id) async {
    return await _notesRepository.fetchNoteById(id);
    notifyListeners();
  }
}
