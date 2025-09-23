class Note {
  final int id;
  final String title;
  final String date;
  //final bool hasAttachment;

  Note({
    required this.id,
    required this.title,
    required this.date,
    //this.hasAttachment = false,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      //hasAttachment: map['hasAttachment'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      //'hasAttachment': hasAttachment ? 1 : 0,
    };
  }
}
