import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:notebook/src/config/app_theme.dart';
import 'package:notebook/src/domain/models/note_model.dart';
import 'package:notebook/src/ui/view_models/notes_view_model.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  final int? noteId;

  const NoteForm({super.key, this.noteId});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final Set<TagsCategory> _selectedTags = {};
  File? _attachment;

  @override
  void initState() {
    if (widget.noteId != null) _loadNoteData(widget.noteId!);

    super.initState();
  }

  Future<void> _loadNoteData(int id) async {
    context.read<NotesViewModel>().getNoteById(id).then((value) {
      if (value != null) {
        _titleController.text = value.title;
        _contentController.text = value.content;
        if (value.tags != null) {
          setState(() {
            _selectedTags.addAll(value.tags!);
          });
        }
        if (value.hasAttachment) {
          setState(() {
            //_attachment = File(value.attachment!);
          });
        }
      }
    });
  }

  Future<void> _pickAttachment() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _attachment = File(file.path);
      });
    }
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final id = widget.noteId != null
          ? widget.noteId!
          : DateTime.now().millisecondsSinceEpoch;
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();
      final tags = _selectedTags.toList();
      final attachment = _attachment;

      final note = Note(
        id: id,
        title: title,
        date: DateFormat('yyyy-MMM-dd').format(DateTime.now()),
        content: content,
        tags: tags,
        attachment: attachment,
      );

      try {
        widget.noteId != null
            ? await context.read<NotesViewModel>().updateNote(note)
            : await context.read<NotesViewModel>().addNote(note);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nota guardada con éxito")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al guardar la nota")),
        );
      }

      _formKey.currentState!.reset();
      setState(() {
        _attachment = null;
        _selectedTags.clear();
      });
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Nota"), elevation: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Título",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
                validator: (value) =>
                    value!.isEmpty ? "El título es obligatorio" : null,
              ),
              const SizedBox(height: 16),

              // Card para Contenido
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Contenido",
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
                validator: (value) =>
                    value!.isEmpty ? "El contenido es obligatorio" : null,
              ),
              const SizedBox(height: 16),

              // Etiquetas
              const Text(
                "Etiquetas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: TagsCategory.values.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    selectedColor: AppTheme().getTheme().primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppTheme().getTheme().textTheme.bodyLarge?.color,
                    ),
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              /*  // Adjunto
              GestureDetector(
                onTap: _pickAttachment,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: _attachment == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.attach_file,
                                size: 25,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Agregar adjunto (imagen/archivo)",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _attachment!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24), */

              // Botón Guardar
              ElevatedButton.icon(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppTheme().getTheme().primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                icon: const Icon(Icons.save),
                label: const Text(
                  "Guardar Nota",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
