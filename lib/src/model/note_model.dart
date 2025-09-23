class Note {
  final String id;
  final String title;
  final String date;
  final bool hasAttachment;

  Note({
    required this.id,
    required this.title,
    required this.date,
    this.hasAttachment = false,
  });
}
