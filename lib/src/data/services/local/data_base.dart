import 'package:notebook/src/domain/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  static final SqlDatabase instance = SqlDatabase._init();

  static Database? _database;

  SqlDatabase._init();

  final String tableNotes = 'notes';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _init('notes.db');
    return _database!;
  }

  Future<Database> _init(String filePath) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);

    return openDatabase(join(path), onCreate: _onCreate, version: 3);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableNotes (
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        date TEXT,
        tag TEXT,
        attachment TEXT
      )
    ''');
  }

  Future insert(Note note) async {
    final db = await instance.database;
    await db.insert(
      tableNotes,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;
    final result = await db.query(tableNotes);
    return result.map((json) => Note.fromMap(json)).toList();
  }

  Future<Note?> getNoteById(int id) async {
    final db = await instance.database;
    final note = await db.query(
      tableNotes,
      columns: ['id', 'content', 'title', 'date', 'tag', 'attachment'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (note.isNotEmpty) {
      return Note.fromMap(note.first);
    } else {
      return null; // Note not found
    }
  }

  Future update(Note note) async {
    final db = await instance.database;
    await db.update(
      tableNotes,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future delete(int id) async {
    final db = await instance.database;
    await db.delete(tableNotes, where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
