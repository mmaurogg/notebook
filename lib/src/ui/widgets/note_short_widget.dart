import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notebook/src/config/app_theme.dart';
import 'package:notebook/src/domain/models/note_model.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(
              color: AppTheme().getTheme().colorScheme.primary.withAlpha(30),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.edit_document,
                  color: AppTheme().getTheme().colorScheme.primary,
                  size: 32,
                ),
              ),
            ),
            title: Text(
              note.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme().getTheme().colorScheme.primary,
              ),
            ),
            subtitle: Text(
              note.date,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: note.hasAttachment
                ? Icon(Icons.attach_file, color: Colors.grey)
                : null,
            onTap: () {
              context.push("/notes/${note.id}");
            },
          ),

          if (note.tags != null && note.tags!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: note.tags!.map((tag) {
                  return Chip(
                    label: Text(tag.name),
                    backgroundColor: AppTheme().getTheme().colorScheme.primary,
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
