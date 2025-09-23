import 'package:flutter/material.dart';
import 'package:notebook/src/model/note_model.dart';
import 'package:notebook/src/providers/notes_provider.dart';
import 'package:notebook/src/ui/widgets/note_short_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  int counter = 0;
  final notes = [
    Note(
      id: 1,
      title: "Recordatorio de cita",
      date: "2024-01-20",
      //hasAttachment: true,
    ),
    Note(id: 2, title: "Lista de compras", date: "2024-01-18"),
    Note(id: 3, title: "Ideas para el proyecto", date: "2024-01-15"),
    Note(
      id: 4,
      title: "Notas de la reunión",
      date: "2024-01-10",
      //hasAttachment: true,
    ),
    Note(id: 5, title: "Plan de viaje", date: "2024-01-05"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Notes")),
        body: HomeView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<NotesProvider>().addNote(notes[counter]);
            counter++;
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<NotesProvider>().loadNotes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NotesProvider>().notes;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scrollbar(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Dismissible(
                key: Key(note.id.toString()),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: NoteShortWidget(note: note),
                onDismissed: (direction) {
                  context
                      .read<NotesProvider>()
                      .removeNote(note)
                      .then(
                        (_) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Nota eliminada')),
                        ),
                      )
                      .onError(
                        (error, stackTrace) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error al eliminar la nota'),
                              ),
                            ),
                      );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
