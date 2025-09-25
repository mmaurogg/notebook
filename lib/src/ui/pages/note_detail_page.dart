import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebook/src/config/app_theme.dart';
import 'package:notebook/src/domain/models/note_model.dart';
import 'package:notebook/src/ui/view_models/notes_view_model.dart';
import 'package:provider/provider.dart';

class NoteDetailPage extends StatelessWidget {
  final int id;
  const NoteDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Note detail")),
        body: NoteDetailView(id: id, viewModel: viewModel),
      ),
    );
  }
}

class NoteDetailView extends StatefulWidget {
  final int id;
  final NotesViewModel viewModel;

  const NoteDetailView({super.key, required this.id, required this.viewModel});

  @override
  State<NoteDetailView> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  Note? note;

  @override
  void initState() {
    widget.viewModel.getNoteById(widget.id).then((value) {
      setState(() {
        note = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (note == null) {
      return Center(child: CircularProgressIndicator());
    }

    return NoteDetailBody(
      note: note!,
      onDelete: () {
        context.read<NotesViewModel>().removeNote(note!);
        context.pop();
      },
      onEdit: () {
        context.pushReplacement('/edit/${note!.id}');
      },
    );
  }
}

class NoteDetailBody extends StatelessWidget {
  final Note note;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const NoteDetailBody({
    super.key,
    required this.note,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    note.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 16,
                  color: AppTheme().getTheme().colorScheme.secondary,
                ),
                SizedBox(width: 5),
                Text(
                  note.date,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme().getTheme().colorScheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Note',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(children: [Text(note.content)]),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            if (note.tags != null && note.tags!.isNotEmpty) ...[
              const Text(
                "Etiquetas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: note.tags!.map((tag) {
                  return Chip(
                    label: Text(
                      tag.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: AppTheme().getTheme().colorScheme.primary,
                    labelStyle: TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
            ],

            if (note.hasAttachment) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withAlpha(30),
                    ),
                    child: Icon(
                      Icons.attachment_rounded,
                      size: 24,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'This note has attachments',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppTheme()
                        .getTheme()
                        .colorScheme
                        .secondary,
                    foregroundColor: Colors.white,
                    elevation: 5,
                  ),
                  child: const Text('Edit'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppTheme().getTheme().colorScheme.error,
                    foregroundColor: Colors.white,
                    elevation: 5,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
