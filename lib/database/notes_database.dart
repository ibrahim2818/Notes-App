import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  NotesDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB('notes.db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT NOT NULL,
           content TEXT NOT NULL,
           date TEXT NOT NULL,
           color INTEGER NOT NULL
      )
    ''');
  }

  Future<int> addNote(
      String title,
      String content,
      int color,
      String date,
      ) async {
    final db = await NotesDatabase.instance.database;

    return await db.insert('notes', {
      'title': title,
      'content': content,
      'date': date,
      'color': color,
    });
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await NotesDatabase.instance.database;
    return await db.query('notes', orderBy: 'date DESC');
  }

  Future<int> updateNote(
      int id,
      String title,
      String content,
      int color,
      String date,
      ) async {
    final db = await NotesDatabase.instance.database;

    return await db.update(
      'notes',
      {
        "title": title,
        "content": content,
        "date": date,
        "color": color,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await NotesDatabase.instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
