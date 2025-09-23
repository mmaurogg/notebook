import 'package:flutter/material.dart';
import 'package:notebook/src/data/repository/notes_repository.dart';
import 'package:notebook/src/model/note_model.dart';

class NotesProvider extends ChangeNotifier {
  //final NotesRepository _notesRepository = NotesRepositoryImpl();

  //NotesProvider(this._notesRepository);

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    //_notes = await _notesRepository.fetchNotes();
    _notes = [
      Note(
        id: '1',
        title: "Recordatorio de cita",
        date: "2024-01-20",
        hasAttachment: true,
      ),
      Note(id: '2', title: "Lista de compras", date: "2024-01-18"),
      Note(id: '3', title: "Ideas para el proyecto", date: "2024-01-15"),
      Note(
        id: '4',
        title: "Notas de la reunión",
        date: "2024-01-10",
        hasAttachment: true,
      ),
      Note(id: '5', title: "Plan de viaje", date: "2024-01-05"),
    ];
    notifyListeners();
  }
}
