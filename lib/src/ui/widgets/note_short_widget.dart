import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebook/src/model/note_model.dart';

class NoteShortWidget extends StatelessWidget {
  final Note note;

  const NoteShortWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.note, color: Colors.blue, size: 32),
        title: Text(note.title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(note.date, style: TextStyle(color: Colors.grey[600])),
        trailing: note.hasAttachment
            ? Icon(Icons.attach_file, color: Colors.grey)
            : null,
        onTap: () {
          context.push("/notes/${note.id}");
        },
      ),
    );
  }
}
