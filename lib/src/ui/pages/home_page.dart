import 'package:flutter/material.dart';
import 'package:notebook/src/model/note_model.dart';
import 'package:notebook/src/providers/notes_provider.dart';
import 'package:notebook/src/ui/widgets/note_short_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Notes")),
        body: HomeView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //context.read<NotesProvider>().loadNotes();
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
              child: NoteShortWidget(note: note),
            );
          },
        ),
      ),
    );
  }
}
