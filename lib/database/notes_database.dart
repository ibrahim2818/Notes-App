import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  NotesDatabase._init();

  static sqflite.Database? _database;

  Future<sqflite.Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB('notes.db');
    return _database!;
  }

  Future<sqflite.Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await sqflite.openDatabase(path,
        version: 1,
        onCreate: _createDB);

  }
}


Future _createDB(sqflite.Database db , int version) async {
  await db.execute('''
      CREATE TABLE notes (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT NOT NULL,
           content TEXT NOT NULL,
           date_created TEXT NOT NULL,
           color INTEGER NOT NULL)
          ''');
}

Future<int> addNote(
String title,
String content,
int color,
String dateCreated,
)