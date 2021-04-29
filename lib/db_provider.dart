import 'package:flutter/foundation.dart';
import 'package:flutter_dicoding_fundamental/database_helper.dart';
import 'package:flutter_dicoding_fundamental/note.dart';

class DbProvider extends ChangeNotifier {
  List<Note> _notes = [];

  // Mengakses database local
  DatabaseHelper _dbHelper;

  List<Note> get notes => _notes;

  // Provider untuk mengambil data
  void _getAllNotes() async {
    _notes = await _dbHelper.getNotes();
    notifyListeners();
  }

  // Provider untuk Add Data
  Future<void> addNote(Note note) async {
    await _dbHelper.insertNote(note);
    _getAllNotes();
  }

  // Provider untuk mengambil data berdasarkanId
  Future<Note> getNoteById(int id) async {
    return await _dbHelper.getNoteById(id);
  }

  // Provider untuk update data
  void updateNote(Note note) async {
    await _dbHelper.updateNote(note);
    _getAllNotes();
  }

  // Provider untuk delete data
  void deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    _getAllNotes();
  }

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllNotes();
  }
}
