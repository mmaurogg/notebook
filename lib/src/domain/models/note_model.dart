import 'dart:io';

enum TagCategory { personal, work, ideas, others }

class Note {
  final int id;
  final String title;
  final String content;
  final String date;
  final List<TagCategory>? tag;
  final File? attachment;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.tag,
    this.attachment,
  });

  bool get hasAttachment => attachment != null;

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
      tag: map['tag'],
      attachment: map['attachment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'tag': tag,
      'attachment': attachment,
    };
  }
}
