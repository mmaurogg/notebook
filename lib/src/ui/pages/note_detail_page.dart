import 'package:flutter/material.dart';
import 'package:notebook/src/model/note_model.dart';

class NoteDetailPage extends StatelessWidget {
  final String id;
  const NoteDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final note = Note(
      id: id,
      title: "Sample Note Title",
      date: "2024-01-20",
      hasAttachment: true,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Note Detail')),
      body: NoteDetailView(note: note),
    );
  }
}

class NoteDetailView extends StatelessWidget {
  final Note note;
  const NoteDetailView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: ${note.title}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Date: ${note.date}',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),

              Text(
                'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letra',
              ),

              SizedBox(height: 24),

              if (note.hasAttachment)
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: Text('Edit')),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
