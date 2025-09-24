import 'package:flutter/material.dart';
import 'package:notebook/src/data/repositories/notes_repository.dart';
import 'package:notebook/src/domain/models/note_model.dart';

class NotesViewModel extends ChangeNotifier {
  final NotesRepository notesRepository;

  NotesViewModel({required this.notesRepository});

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  int counter = 0;

  Future<void> loadNotes() async {
    _notes = await notesRepository.fetchNotes();
    notifyListeners();
  }

  Future<Note?> getNoteById(int id) async {
    return await notesRepository.fetchNoteById(id);
    //notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await notesRepository.addNote(note);
    loadNotes();
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await notesRepository.updateNote(note);
    _notes.removeWhere((n) => n.id == note.id);
    _notes.add(note);
    notifyListeners();
  }

  Future<void> removeNote(Note note) async {
    await notesRepository.deleteNoteById(note.id);
    _notes.removeWhere((n) => n.id == note.id);
    notifyListeners();
  }

  Note getFakeNote() {
    counter++;
    return Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: "Note $counter",
      content: "This is the content of note $counter",
      date: DateTime.now().toString(),
    );
  }
}
