import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebook/src/ui/view_models/notes_view_model.dart';
import 'package:notebook/src/ui/widgets/note_short_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Notes")),
        body: HomeView(viewModel: viewModel),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/add');
            //viewModel.loadNotes();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  final NotesViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    widget.viewModel.loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NotesViewModel>().notes;

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
                key: Key(note.date.toString()),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: NoteShortWidget(note: note),
                onDismissed: (direction) {
                  //widget.viewModel
                  context
                      .read<NotesViewModel>()
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
