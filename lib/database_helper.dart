import 'package:flutter_dicoding_fundamental/note.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  static String _tableName = 'notes';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/note_db.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               title TEXT, description TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  // Fungsi menyimpan data local
  Future<void> insertNote(Note note) async {
    final Database db = await database;
    await db.insert(_tableName, note.toMap());
    print('data saved');
  }

  // Menampilkan seluruh data
  Future<List<Note>> getNotes() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Note.fromMap(res)).toList();
  }

  // Mengambil Data dari ID
  Future<Note> getNoteById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    return results.map((res) => Note.fromMap(res)).first;
  }

  // Update Data
  Future<void> updateNote(Note note) async {
    final db = await _database;

    await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // Delete Data
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
