import 'dart:io';

enum TagsCategory { personal, work, ideas, others }

TagsCategory? tagsCategoryFromString(String name) {
  try {
    return TagsCategory.values.firstWhere((tag) => tag.name == name);
  } catch (e) {
    return null;
  }
}

class Note {
  final int id;
  final String title;
  final String content;
  final String date;
  final List<TagsCategory>? tags;
  final File? attachment;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.tags,
    this.attachment,
  });

  bool get hasAttachment => attachment != null;

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
      tags: map['tags'] == null
          ? null
          : (map['tags'] as String?)
                ?.split(',')
                .map((name) => tagsCategoryFromString(name))
                .where((tag) => tag != null)
                .cast<TagsCategory>()
                .toList(),
      attachment: map['attachment'],
    );
  }

  Map<String, dynamic> toMap() {
    final tagsAsString = tags?.map((tag) => tag.name).join(',');

    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'tags': tags == null ? null : tagsAsString,
      'attachment': attachment,
    };
  }
}
